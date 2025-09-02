import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_event.freezed.dart';

@freezed
class ActivityEvent with _$ActivityEvent {
  // Basic data operations
  const factory ActivityEvent.fetchData() = FetchActivityData;
  const factory ActivityEvent.refreshData() = RefreshActivityData;
  const factory ActivityEvent.loadCachedData() = LoadCachedData;
  const factory ActivityEvent.clearCache() = ClearCache;

  // Permission management
  const factory ActivityEvent.requestAuthorization() = RequestAuthorization;
  const factory ActivityEvent.checkPermissions() = CheckPermissions;

  // Activity plan management
  const factory ActivityEvent.registerPlan({
    required String activityName,
    Map<String, dynamic>? planData,
  }) = RegisterActivityPlan;
  const factory ActivityEvent.updatePlan({
    required String activityName,
    Map<String, dynamic>? planData,
  }) = UpdateActivityPlan;
}
