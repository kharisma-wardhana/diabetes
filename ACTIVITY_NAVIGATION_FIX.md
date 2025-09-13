# ActivityPage Navigation Issue Analysis & Solutions

## Issues Identified

### 1. **Race Condition with GlobalAuthListener**
**Problem**: The recommendation page briefly appears after successful activity registration due to a race condition between:
- ActivityPage navigating to homePage with `arguments: 1`
- GlobalAuthListener triggering navigation to homePage with `arguments: 0`

**Root Cause**: When the ActivityBloc succeeds and triggers navigation, the AuthBloc state might also be changing (due to diabetes type updates), causing GlobalAuthListener to interfere with the intended navigation.

**Solution**: Modified `GlobalAuthListener` to:
- Add async support to the listener function
- Include a small delay (50ms) before navigation to prevent race conditions
- Double-check the current route after the delay to avoid unwanted navigation
- Skip auto-navigation if already on activity-related or home pages

### 2. **ActivityController Validation Issues**
**Problem**: The `activityController` was initialized with `text: '-'` but validation checked for `!= '-'`, causing potential edge cases.

**Solution**: 
- Changed initial value from `'-'` to empty string `''`
- Enhanced validation logic to check for both `isNotEmpty` and `!= '-'`
- Added proper trimming of input values to prevent whitespace issues

### 3. **RegisterActivityPlan Error Handling**
**Problem**: The original RegisterActivityPlan flow didn't properly handle errors from the `addActivityUsecase`, which could cause state inconsistencies.

**Solution**: 
- Improved error handling in `_onRegisterActivityPlan` method
- Added proper error checking using `fold()` pattern
- Added stack trace capture for better debugging
- Added a small delay before triggering `FetchActivityData` to ensure activity is saved
- Added `isClosed` check to prevent events being added to closed blocs

### 4. **Activity Navigation Timing**
**Problem**: Navigation was happening immediately after state success, which could conflict with other state changes.

**Solution**: 
- Added a small delay (100ms) before navigation in the success state
- Added mounted check before navigation to prevent issues with disposed widgets

## Implementation Details

### Modified Files:

1. **`global_auth_listener.dart`**:
   - Made listener function async
   - Added delay and double-checking logic
   - Improved route checking logic

2. **`activity_bloc.dart`**:
   - Enhanced error handling in `_onRegisterActivityPlan`
   - Added proper result handling with `fold()`
   - Added safety checks for bloc lifecycle

3. **`activity_page.dart`**:
   - Fixed activity controller initialization
   - Improved validation logic
   - Enhanced step target validation
   - Added navigation delay for better reliability
   - Improved input trimming and validation

## Code Changes Summary

### GlobalAuthListener Fix:
```dart
// Added async support and race condition prevention
listener: (context, state) async {
  // ... existing logic ...
  await Future.delayed(const Duration(milliseconds: 50));
  // Double check route after delay
  final currentRouteAfterDelay = ModalRoute.of(context)?.settings.name;
  if (currentRouteAfterDelay == gulaDarahPage || /* other pages */) {
    return; // Skip navigation
  }
  // ... proceed with navigation
}
```

### ActivityBloc Enhancement:
```dart
// Improved error handling
addResult.fold(
  (failure) {
    emit(ActivityState.error(/* proper error handling */));
    return;
  },
  (success) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!isClosed) {
        add(FetchActivityData(goals: goals, bloodSugar: event.bloodSugar));
      }
    });
  },
);
```

### ActivityPage Validation:
```dart
// Enhanced validation
if (_formKey.currentState!.validate() && 
    activityController.text.isNotEmpty && 
    activityController.text != '-') {
  // ... validation logic with proper trimming
  final stepValue = int.tryParse(stepController.text);
  if (stepValue == null || stepValue <= 0) {
    // Show error and return
  }
  // ... proceed with cleaned data
}
```

## Testing Recommendations

1. **Test the navigation flow**: Ensure recommendation page no longer briefly appears
2. **Test validation**: Try various edge cases with empty/invalid activity selections
3. **Test error handling**: Simulate network errors during activity registration
4. **Test concurrent operations**: Ensure no race conditions between auth state and activity state changes

## Performance Impact

- Minimal performance impact due to small delays (50-100ms)
- Improved reliability and user experience
- Better error handling prevents app crashes
- Reduced unnecessary navigation calls

## Future Improvements

1. Consider implementing a navigation queue system for complex flows
2. Add more robust state management for multi-step flows
3. Consider using a state machine pattern for complex navigation scenarios
4. Add analytics/logging for better debugging of navigation issues
