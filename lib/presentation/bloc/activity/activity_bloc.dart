import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/usecase/health/authorization_usecase.dart';
import '../../../domain/usecase/health/health_usecase.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final AuthorizationUseCase authorizationUsecase;
  final HealthUseCase healthUsecase;

  ActivityBloc({
    required this.authorizationUsecase,
    required this.healthUsecase,
  }) : super(const ActivityState.initial()) {
    // Basic data operations
    on<FetchActivityData>(_onFetchActivityData);
    on<RefreshActivityData>(_onRefreshActivityData);
    on<ClearActivityData>(_onClearActivityData);

    // Permission management
    on<RequestAuthorization>(_onRequestAuthorization);
    on<CheckPermissions>(_onCheckPermissions);

    // Activity plan management
    on<RegisterActivityPlan>(_onRegisterActivityPlan);
    on<UpdateActivityPlan>(_onUpdateActivityPlan);
    on<DeleteActivityPlan>(_onDeleteActivityPlan);

    // Data synchronization
    on<StartSync>(_onStartSync);
    on<StopSync>(_onStopSync);
    on<ForceSync>(_onForceSync);

    // Activity tracking
    on<StartActivityTracking>(_onStartActivityTracking);
    on<StopActivityTracking>(_onStopActivityTracking);
    on<PauseActivityTracking>(_onPauseActivityTracking);
    on<ResumeActivityTracking>(_onResumeActivityTracking);
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

    await authorizationUsecase.call(types);

    final data = await healthUsecase.call(types);
    data.fold(
      (failure) => emit(ActivityState.error(message: failure.message)),
      (data) => emit(
        ActivityState.success(data: data, message: 'Data fetched successfully'),
      ),
    );
  }

  Future<void> _onRefreshActivityData(
    RefreshActivityData event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Refreshing activity data...'));
    // Add refresh logic here
    add(const ActivityEvent.fetchData());
  }

  Future<void> _onClearActivityData(
    ClearActivityData event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.empty('Activity data cleared'));
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
      emit(const ActivityState.permissionsGranted());
      add(const ActivityEvent.fetchData());
    } else {
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
      emit(const ActivityState.permissionsGranted());
    } else {
      emit(const ActivityState.permissionsDenied());
    }
  }

  Future<void> _onRegisterActivityPlan(
    RegisterActivityPlan event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Registering activity plan...'));

    try {
      // Simulate plan registration logic
      await Future.delayed(const Duration(seconds: 2));
      final planId = DateTime.now().millisecondsSinceEpoch.toString();

      emit(
        ActivityState.planRegistered(
          planId: planId,
          message: 'Activity plan registered successfully',
        ),
      );
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
      // Simulate plan update logic
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ActivityState.planUpdated(
          planId: event.planId,
          message: 'Activity plan updated successfully',
        ),
      );
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to update activity plan',
          error: error,
        ),
      );
    }
  }

  Future<void> _onDeleteActivityPlan(
    DeleteActivityPlan event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Deleting activity plan...'));

    try {
      // Simulate plan deletion logic
      await Future.delayed(const Duration(seconds: 1));

      emit(const ActivityState.empty('Activity plan deleted successfully'));
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to delete activity plan',
          error: error,
        ),
      );
    }
  }

  Future<void> _onStartSync(
    StartSync event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.synchronizing('Starting data synchronization...'));

    try {
      // Simulate sync logic
      await Future.delayed(const Duration(seconds: 3));

      emit(
        ActivityState.syncCompleted(
          lastSync: DateTime.now(),
          message: 'Data synchronization completed',
        ),
      );
    } catch (error) {
      emit(
        ActivityState.error(message: 'Synchronization failed', error: error),
      );
    }
  }

  Future<void> _onStopSync(StopSync event, Emitter<ActivityState> emit) async {
    emit(const ActivityState.initial());
  }

  Future<void> _onForceSync(
    ForceSync event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.synchronizing('Force synchronizing data...'));
    add(const ActivityEvent.startSync());
  }

  Future<void> _onStartActivityTracking(
    StartActivityTracking event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Starting activity tracking...'));

    try {
      // Simulate tracking start logic
      await Future.delayed(const Duration(seconds: 1));

      emit(
        ActivityState.success(
          data: await _getCurrentHealthData(),
          message: 'Activity tracking started for ${event.activityType}',
        ),
      );
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to start activity tracking',
          error: error,
        ),
      );
    }
  }

  Future<void> _onStopActivityTracking(
    StopActivityTracking event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Stopping activity tracking...'));

    try {
      // Simulate tracking stop logic
      await Future.delayed(const Duration(seconds: 1));

      emit(const ActivityState.empty('Activity tracking stopped'));
    } catch (error) {
      emit(
        ActivityState.error(
          message: 'Failed to stop activity tracking',
          error: error,
        ),
      );
    }
  }

  Future<void> _onPauseActivityTracking(
    PauseActivityTracking event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Pausing activity tracking...'));
    // Add pause logic here
  }

  Future<void> _onResumeActivityTracking(
    ResumeActivityTracking event,
    Emitter<ActivityState> emit,
  ) async {
    emit(const ActivityState.loading('Resuming activity tracking...'));
    // Add resume logic here
  }

  // Helper method to get current health data
  Future<dynamic> _getCurrentHealthData() async {
    // This should return actual HealthEntity data
    // For now, returning a placeholder
    return {};
  }
}
