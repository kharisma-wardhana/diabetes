import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_event.freezed.dart';

@freezed
class ActivityEvent with _$ActivityEvent {
  // Basic data operations
  const factory ActivityEvent.fetchData() = FetchActivityData;
  const factory ActivityEvent.refreshData() = RefreshActivityData;
  const factory ActivityEvent.clearData() = ClearActivityData;

  // Permission management
  const factory ActivityEvent.requestAuthorization() = RequestAuthorization;
  const factory ActivityEvent.checkPermissions() = CheckPermissions;

  // Activity plan management
  const factory ActivityEvent.registerPlan({
    required String planType,
    required Map<String, dynamic> planData,
  }) = RegisterActivityPlan;
  const factory ActivityEvent.updatePlan({
    required String planId,
    required Map<String, dynamic> planData,
  }) = UpdateActivityPlan;
  const factory ActivityEvent.deletePlan({required String planId}) =
      DeleteActivityPlan;

  // Data synchronization
  const factory ActivityEvent.startSync() = StartSync;
  const factory ActivityEvent.stopSync() = StopSync;
  const factory ActivityEvent.forceSync() = ForceSync;

  // Activity tracking
  const factory ActivityEvent.startTracking({required String activityType}) =
      StartActivityTracking;
  const factory ActivityEvent.stopTracking() = StopActivityTracking;
  const factory ActivityEvent.pauseTracking() = PauseActivityTracking;
  const factory ActivityEvent.resumeTracking() = ResumeActivityTracking;
}
