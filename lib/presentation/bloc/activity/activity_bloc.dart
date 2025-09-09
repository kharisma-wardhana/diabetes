import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/activity/activity_entity.dart';
import '../../../domain/entity/health/health_entity.dart';
import '../../../domain/usecase/assesment/add_activity_usecase.dart';
import '../../../domain/usecase/health/authorization_usecase.dart';
import '../../../domain/usecase/health/health_usecase.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final AuthorizationUseCase authorizationUsecase;
  final HealthUseCase healthUsecase;
  final AddActivityUseCase addActivityUsecase;
  final FlutterSecureStorage storage;

  // Storage keys
  static const String _activityDataKey = 'activity_data';
  static const String _permissionsStatusKey = 'permissions_status';
  static const String _lastSyncTimeKey = 'last_sync_time';

  ActivityBloc({
    required this.authorizationUsecase,
    required this.healthUsecase,
    required this.addActivityUsecase,
    required this.storage,
  }) : super(const ActivityState.initial()) {
    // Basic data operations
    on<FetchActivityData>(_onFetchActivityData);
    on<RefreshActivityData>(_onRefreshActivityData);
    on<LoadCachedData>(_onLoadCachedData);
    on<ClearCache>(_onClearCache);

    // Permission management
    on<RequestAuthorization>(_onRequestAuthorization);
    on<CheckPermissions>(_onCheckPermissions);

    // Activity plan management
    on<RegisterActivityPlan>(_onRegisterActivityPlan);
    on<UpdateActivityPlan>(_onUpdateActivityPlan);

    // Load persisted state on initialization
    _loadPersistedState();
  }

  Future<void> _onFetchActivityData(
    FetchActivityData event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Fetching activity data...'));
    final types = [
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ];

    final permissions = [
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
      HealthDataAccess.READ,
    ];

    await authorizationUsecase.call(
      HealthParams(types: types, permissions: permissions),
    );
    final result = await healthUsecase.call(
      ActivityGoalsParams(
        types: types,
        bloodSugar: event.bloodSugar ?? 0,
        goals: event.goals ?? 5000,
      ),
    );
    result.fold(
      (failure) {
        failure is NotFoundFailure
            ? emit(const ActivityState.empty('No activity data found'))
            : emit(
                ActivityState.error(
                  message: 'Failed to fetch activity data',
                  error: failure,
                ),
              );
      },
      (data) {
        // Save successful data to storage
        _saveActivityData(data);
        emit(
          ActivityState.success(
            data: data,
            message: 'Data fetched successfully',
          ),
        );
      },
    );
  }

  Future<void> _onRefreshActivityData(
    RefreshActivityData event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Refreshing activity data...'));
    // Pass the bloodSugar and goals parameters from the refresh event
    add(
      ActivityEvent.fetchData(bloodSugar: event.bloodSugar, goals: event.goals),
    );
  }

  Future<void> _onLoadCachedData(
    LoadCachedData event,
    Emitter<ActivityState> emit,
  ) async {
    try {
      final activityDataJson = await storage.read(key: _activityDataKey);
      if (activityDataJson != null) {
        final data = HealthEntity.fromJson(jsonDecode(activityDataJson));
        emit(
          ActivityState.success(
            data: data,
            message: 'Loaded cached activity data',
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading cached data: $e');
      }
      // If error loading cache, proceed with fresh data fetch
      add(const ActivityEvent.fetchData());
    }
  }

  Future<void> _onClearCache(
    ClearCache event,
    Emitter<ActivityState> emit,
  ) async {
    await _clearPersistedData();
    emit(const ActivityState.initial());
  }

  Future<void> _onRequestAuthorization(
    RequestAuthorization event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.checkPermissions());

    // Request permissions for activity recognition and sensors
    final activityPermission = await Permission.activityRecognition.request();
    final sensorsPermission = await Permission.sensors.request();

    if (activityPermission.isGranted && sensorsPermission.isGranted) {
      _savePermissionsStatus(true);
      emit(const ActivityState.permissionsGranted());
      add(const ActivityEvent.fetchData());
    } else {
      _savePermissionsStatus(false);
      emit(const ActivityState.permissionsDenied());
    }
  }

  Future<void> _onCheckPermissions(
    CheckPermissions event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.checkPermissions());

    final activityPermission = await Permission.activityRecognition.status;
    final sensorsPermission = await Permission.sensors.status;

    if (activityPermission.isGranted && sensorsPermission.isGranted) {
      _savePermissionsStatus(true);
      emit(const ActivityState.permissionsGranted());
      add(const ActivityEvent.fetchData());
    } else {
      _savePermissionsStatus(false);
      emit(const ActivityState.permissionsDenied());
    }
  }

  Future<void> _onRegisterActivityPlan(
    RegisterActivityPlan event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Registering activity plan...'));

    try {
      final goals =
          event.planData != null && event.planData!.containsKey('target_steps')
          ? int.tryParse(event.planData!['target_steps'].toString()) ?? 5000
          : 5000;
      await addActivityUsecase.call(
        AddParams(
          data: ActivityEntity(
            name: event.activityName,
            date: DateTime.now().toIso8601String().split('T')[0],
            hour: 0,
            minute: 0,
            stepGoal: goals,
          ),
        ),
      );
      // Fetch data with blood sugar value if available in the event
      add(FetchActivityData(goals: goals, bloodSugar: event.bloodSugar));
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to register activity plan',
          error: error,
        ),
      );
    }
  }

  Future<void> _onUpdateActivityPlan(
    UpdateActivityPlan event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Updating activity plan...'));

    try {
      await addActivityUsecase.call(
        AddParams(
          data: ActivityEntity(
            name: event.activityName,
            date: DateTime.now().toIso8601String().split('T')[0],
            hour: 0,
            minute: 0,
          ),
        ),
      );
      add(FetchActivityData(bloodSugar: event.bloodSugar));
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to update activity plan',
          error: error,
        ),
      );
    }
  }

  // Persistence methods
  Future<void> _loadPersistedState() async {
    try {
      // Check if we have cached activity data and trigger loading if found
      final activityDataJson = await storage.read(key: _activityDataKey);
      if (activityDataJson != null) {
        // Add an event to load the cached data
        add(const LoadCachedData());
      }

      // Check permissions status
      final permissionsStatus = await storage.read(key: _permissionsStatusKey);
      if (permissionsStatus == 'denied') {
        add(const CheckPermissions());
      }
    } catch (e) {
      if (kDebugMode) {
        // If there's an error loading persisted state, continue with initial state
        print('Error loading persisted state: $e');
      }
    }
  }

  Future<void> _saveActivityData(HealthEntity data) async {
    try {
      await storage.write(
        key: _activityDataKey,
        value: jsonEncode(data.toJson()),
      );
      await storage.write(
        key: _lastSyncTimeKey,
        value: DateTime.now().toIso8601String(),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving activity data: $e');
      }
    }
  }

  Future<void> _savePermissionsStatus(bool granted) async {
    try {
      await storage.write(
        key: _permissionsStatusKey,
        value: granted ? 'granted' : 'denied',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error saving permissions status: $e');
      }
    }
  }

  Future<void> _clearPersistedData() async {
    try {
      await storage.delete(key: _activityDataKey);
      await storage.delete(key: _permissionsStatusKey);
      await storage.delete(key: _lastSyncTimeKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing persisted data: $e');
      }
    }
  }
}
