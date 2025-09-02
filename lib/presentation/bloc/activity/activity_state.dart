import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/health/health_entity.dart';

part 'activity_state.freezed.dart';

@freezed
class ActivityState with _$ActivityState {
  // Base states (equivalent to BaseState<HealthEntity>)
  const factory ActivityState.initial() = _Initial;
  const factory ActivityState.loading([String? message]) = _Loading;
  const factory ActivityState.success({
    required HealthEntity data,
    String? message,
  }) = _Success;
  const factory ActivityState.error({
    required String message,
    Object? error,
    StackTrace? stackTrace,
  }) = _Error;
  const factory ActivityState.empty([String? message]) = _Empty;

  // Custom activity-specific states
  const factory ActivityState.checkPermissions() = _CheckPermissions;
  const factory ActivityState.permissionsGranted() = _PermissionsGranted;
  const factory ActivityState.permissionsDenied() = _PermissionsDenied;
}

// Extension to provide BaseState-like functionality
extension ActivityStateExtensions on ActivityState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isError => this is _Error;
  bool get isEmpty => this is _Empty;
  bool get isCheckingPermissions => this is _CheckPermissions;
  bool get arePermissionsGranted => this is _PermissionsGranted;
  bool get arePermissionsDenied => this is _PermissionsDenied;

  HealthEntity? get data => mapOrNull(success: (state) => state.data);
  String? get message => mapOrNull(
    loading: (state) => state.message,
    success: (state) => state.message,
    error: (state) => state.message,
    empty: (state) => state.message,
  );
  String? get errorMessage => mapOrNull(error: (state) => state.message);
}
