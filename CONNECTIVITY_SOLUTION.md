# Global Connectivity Management Solution

## Overview

This implementation provides a global connectivity management system that can handle connectivity changes and automatically retrigger any bloc when the connection changes from offline to online.

## Key Components

### 1. GlobalConnectivityManager (`lib/core/connectivity_manager.dart`)

A singleton class that:
- Monitors device connectivity status
- Manages a registry of connectivity-aware blocs
- Notifies all registered blocs when connectivity changes
- Provides a centralized way to handle connectivity across the entire app

### 2. ConnectivityAware Interface

An interface that blocs can implement to receive connectivity notifications:

```dart
abstract class ConnectivityAware {
  void onConnectivityRestored();  // Called when going from offline to online
  void onConnectivityLost();      // Called when going from online to offline
  void onConnectivityChanged(bool isConnected); // Called on any change
}
```

### 3. ConnectivityAwareMixin

A mixin that provides convenient methods for registering/unregistering connectivity updates:

```dart
mixin ConnectivityAwareMixin {
  void registerForConnectivityUpdates();
  void unregisterFromConnectivityUpdates();
}
```

## Usage

### Making Any Bloc Connectivity-Aware

To make any bloc connectivity-aware, follow these steps:

1. **Implement the interface and use the mixin:**

```dart
class YourBloc extends Bloc<YourEvent, YourState> 
    with ConnectivityAwareMixin 
    implements ConnectivityAware {
  
  YourBloc() : super(YourInitialState()) {
    // Register for connectivity updates
    registerForConnectivityUpdates();
    
    // Your bloc event handlers...
  }

  // Implement ConnectivityAware methods
  @override
  void onConnectivityRestored() {
    // This is called when connection is restored
    // Add your logic here, e.g., refresh data
    add(RefreshDataEvent());
  }

  @override
  void onConnectivityLost() {
    // Called when connection is lost
    // Optional: handle offline state
  }

  @override
  void onConnectivityChanged(bool isConnected) {
    // Called on any connectivity change
    // Optional: general connectivity handling
  }

  @override
  Future<void> close() {
    // Important: Unregister when bloc is disposed
    unregisterFromConnectivityUpdates();
    return super.close();
  }
}
```

### Example Implementation

See `lib/presentation/bloc/example_bloc.dart` for a complete example of how to implement a connectivity-aware bloc.

## Setup

### 1. Initialize in main.dart

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize global connectivity monitoring
  GlobalConnectivityManager().initialize();
  
  runApp(const MyApp());
}
```

### 2. Current Implementation

The `AuthBloc` is already updated to use this system and will automatically retrigger authentication when connectivity is restored.

## Benefits

1. **Centralized Management**: All connectivity logic is managed in one place
2. **Scalable**: Easy to add connectivity awareness to any new bloc
3. **Automatic**: Blocs automatically receive notifications without manual setup
4. **Clean**: Separates connectivity concerns from business logic
5. **Flexible**: Each bloc can decide how to handle connectivity changes

## Migration from Individual Bloc Connectivity

If you have blocs with individual connectivity handling:

1. Remove individual connectivity subscriptions
2. Implement `ConnectivityAware` interface
3. Use `ConnectivityAwareMixin`
4. Register/unregister in constructor/close methods
5. Move connectivity logic to the interface methods

## Testing

The system is designed to be easily testable:
- Mock `GlobalConnectivityManager` for unit tests
- Test connectivity-aware blocs independently
- Verify registration/unregistration in bloc tests

## Error Handling

The system includes proper error handling:
- Try-catch blocks around listener notifications
- Debug logging for registration/unregistration
- Graceful handling of listener errors

This global approach ensures that any bloc in your application can easily respond to connectivity changes without duplicating connectivity monitoring code.
