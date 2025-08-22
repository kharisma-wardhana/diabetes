import 'package:bloc/bloc.dart';

import '../../core/connectivity_manager.dart';

// Example event
abstract class ExampleEvent {
  const ExampleEvent();
}

class LoadDataEvent extends ExampleEvent {
  const LoadDataEvent();
}

class RefreshDataEvent extends ExampleEvent {
  const RefreshDataEvent();
}

// Example state
abstract class ExampleState {
  const ExampleState();
}

class ExampleInitial extends ExampleState {
  const ExampleInitial();
}

class ExampleLoading extends ExampleState {
  const ExampleLoading();
}

class ExampleLoaded extends ExampleState {
  final String data;
  const ExampleLoaded(this.data);
}

class ExampleError extends ExampleState {
  final String message;
  const ExampleError(this.message);
}

// Example bloc that implements ConnectivityAware
class ExampleBloc extends Bloc<ExampleEvent, ExampleState>
    with ConnectivityAwareMixin
    implements ConnectivityAware {
  ExampleBloc() : super(const ExampleInitial()) {
    // Register for connectivity updates
    registerForConnectivityUpdates();

    on<LoadDataEvent>((event, emit) async {
      emit(const ExampleLoading());
      try {
        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));
        emit(const ExampleLoaded('Data loaded successfully'));
      } catch (e) {
        emit(ExampleError(e.toString()));
      }
    });

    on<RefreshDataEvent>((event, emit) async {
      // Similar to LoadDataEvent but for refresh
      emit(const ExampleLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(const ExampleLoaded('Data refreshed successfully'));
      } catch (e) {
        emit(ExampleError(e.toString()));
      }
    });
  }

  // ConnectivityAware implementation
  @override
  void onConnectivityRestored() {
    // Automatically refresh data when connectivity is restored
    add(const RefreshDataEvent());
  }

  @override
  void onConnectivityLost() {
    // Handle connectivity loss if needed
    // For example, you might want to emit a specific state
    // emit(const ExampleError('No internet connection'));
  }

  @override
  void onConnectivityChanged(bool isConnected) {
    // Handle general connectivity changes if needed
    if (!isConnected) {
      // Maybe show cached data or offline mode
    }
  }

  @override
  Future<void> close() {
    // Unregister from connectivity updates
    unregisterFromConnectivityUpdates();
    return super.close();
  }
}
