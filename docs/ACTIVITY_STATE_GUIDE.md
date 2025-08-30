# ActivityState with BaseState Extension Guide

## Overview

This guide shows how to extend `ActivityState` with `BaseState`-like functionality while adding custom activity-specific states and events using Freezed.

## Key Implementation Details

### 1. ActivityState Structure

Instead of directly extending `BaseState<T>` (which causes complications with Freezed), we implement the base state variants directly in `ActivityState`:

```dart
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
  const factory ActivityState.planRegistered({
    required String planId,
    String? message,
  }) = _PlanRegistered;
  const factory ActivityState.planUpdated({
    required String planId,
    String? message,
  }) = _PlanUpdated;
  const factory ActivityState.synchronizing([String? message]) = _Synchronizing;
  const factory ActivityState.syncCompleted({
    required DateTime lastSync,
    String? message,
  }) = _SyncCompleted;
}
```

### 2. Extension Methods for BaseState-like Functionality

```dart
extension ActivityStateExtensions on ActivityState {
  // Basic state checks (equivalent to BaseState extensions)
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isError => this is _Error;
  bool get isEmpty => this is _Empty;
  
  // Activity-specific state checks
  bool get isCheckingPermissions => this is _CheckPermissions;
  bool get arePermissionsGranted => this is _PermissionsGranted;
  bool get arePermissionsDenied => this is _PermissionsDenied;
  bool get isPlanRegistered => this is _PlanRegistered;
  bool get isPlanUpdated => this is _PlanUpdated;
  bool get isSynchronizing => this is _Synchronizing;
  bool get isSyncCompleted => this is _SyncCompleted;

  // Data and message extraction
  HealthEntity? get data => mapOrNull(success: (state) => state.data);
  String? get message => mapOrNull(
    loading: (state) => state.message,
    success: (state) => state.message,
    error: (state) => state.message,
    empty: (state) => state.message,
    planRegistered: (state) => state.message,
    planUpdated: (state) => state.message,
    synchronizing: (state) => state.message,
    syncCompleted: (state) => state.message,
  );
  
  // Custom data extraction
  String? get planId => mapOrNull(
    planRegistered: (state) => state.planId,
    planUpdated: (state) => state.planId,
  );
  DateTime? get lastSync => mapOrNull(syncCompleted: (state) => state.lastSync);
}
```

### 3. Enhanced ActivityEvent with Custom Events

```dart
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
  const factory ActivityEvent.deletePlan({
    required String planId,
  }) = DeleteActivityPlan;
  
  // Data synchronization
  const factory ActivityEvent.startSync() = StartSync;
  const factory ActivityEvent.stopSync() = StopSync;
  const factory ActivityEvent.forceSync() = ForceSync;
  
  // Activity tracking
  const factory ActivityEvent.startTracking({
    required String activityType,
  }) = StartActivityTracking;
  const factory ActivityEvent.stopTracking() = StopActivityTracking;
  const factory ActivityEvent.pauseTracking() = PauseActivityTracking;
  const factory ActivityEvent.resumeTracking() = ResumeActivityTracking;
}
```

## Benefits of This Approach

### 1. **BaseState Compatibility**
- Maintains all the standard loading, success, error, initial, and empty states
- Provides familiar extension methods for state checking
- Compatible with existing BaseState patterns

### 2. **Custom Activity Features**
- Permission management states
- Activity plan lifecycle states
- Data synchronization states  
- Activity tracking states

### 3. **Type Safety**
- Full type safety with Freezed generated code
- Pattern matching with `when` and `maybeWhen`
- Null-safe data extraction methods

### 4. **Extensible Design**
- Easy to add new custom states
- Helper extension methods for common operations
- Composable state checking logic

## Usage Examples

### Basic State Handling
```dart
// Check if loading
if (state.isLoading) {
  return CircularProgressIndicator();
}

// Check if successful
if (state.isSuccess) {
  return DataWidget(data: state.data!);
}

// Check if error
if (state.isError) {
  return ErrorWidget(message: state.errorMessage!);
}
```

### Custom Activity State Handling
```dart
// Check permissions
if (state.arePermissionsDenied) {
  return PermissionRequestWidget();
}

// Handle plan registration
if (state.isPlanRegistered) {
  final planId = state.planId!;
  return Text('Plan $planId registered successfully');
}

// Handle synchronization
if (state.isSynchronizing) {
  return LinearProgressIndicator();
}
```

### Pattern Matching
```dart
state.when(
  loading: (message) => LoadingWidget(message: message),
  success: (data, message) => DataWidget(data: data),
  error: (message, error, stackTrace) => ErrorWidget(message: message),
  checkPermissions: () => PermissionCheckWidget(),
  planRegistered: (planId, message) => SuccessWidget(message: message),
  // ... other states
);
```

### BlocListener Usage
```dart
BlocListener<ActivityBloc, ActivityState>(
  listener: (context, state) {
    state.maybeWhen(
      permissionsGranted: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissions granted!')),
        );
      },
      error: (message, error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $message')),
        );
      },
      orElse: () {},
    );
  },
  child: YourWidget(),
)
```

## Best Practices

1. **Use Extension Methods**: Leverage extension methods for additional functionality without modifying the core state
2. **Pattern Matching**: Use `when` and `maybeWhen` for exhaustive state handling
3. **Type Safety**: Always check for null when accessing optional data
4. **Consistent Naming**: Follow consistent naming conventions for custom states
5. **Documentation**: Document custom states and their intended usage

## Generated Files

After running `dart run build_runner build`, the following files are generated:
- `activity_state.freezed.dart` - Contains all the state classes and pattern matching methods
- `activity_event.freezed.dart` - Contains all the event classes

This approach gives you the full power of BaseState while allowing for domain-specific customization and type safety.
