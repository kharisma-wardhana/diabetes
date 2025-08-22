import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Interface that blocs can implement to be notified of connectivity changes
abstract class ConnectivityAware {
  /// Called when device goes from offline to online
  void onConnectivityRestored();

  /// Called when device goes from online to offline
  void onConnectivityLost();

  /// Called on any connectivity change
  void onConnectivityChanged(bool isConnected);
}

/// Global connectivity manager that manages all connectivity-aware blocs
class GlobalConnectivityManager {
  static final GlobalConnectivityManager _instance =
      GlobalConnectivityManager._internal();
  factory GlobalConnectivityManager() => _instance;
  GlobalConnectivityManager._internal();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isConnected = true;
  bool _wasOffline = false;

  final Set<ConnectivityAware> _listeners = <ConnectivityAware>{};

  /// Initialize connectivity monitoring
  void initialize() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        debugPrint('Global connectivity stream error: $error');
      },
    );

    // Check initial connectivity
    _checkInitialConnectivity();
  }

  /// Register a bloc/cubit to receive connectivity notifications
  void registerListener(ConnectivityAware listener) {
    _listeners.add(listener);
    debugPrint('Registered connectivity listener: ${listener.runtimeType}');
  }

  /// Unregister a bloc/cubit from connectivity notifications
  void unregisterListener(ConnectivityAware listener) {
    _listeners.remove(listener);
    debugPrint('Unregistered connectivity listener: ${listener.runtimeType}');
  }

  /// Get current connectivity status
  bool get isConnected => _isConnected;

  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _onConnectivityChanged(result);
    } catch (e) {
      debugPrint('Error checking initial connectivity: $e');
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final bool hasConnection = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (_isConnected != hasConnection) {
      _isConnected = hasConnection;

      // Notify all registered listeners
      for (final listener in _listeners) {
        try {
          listener.onConnectivityChanged(hasConnection);

          if (!_isConnected) {
            listener.onConnectivityLost();
          } else if (_wasOffline && _isConnected) {
            listener.onConnectivityRestored();
          }
        } catch (e) {
          debugPrint(
            'Error notifying connectivity listener ${listener.runtimeType}: $e',
          );
        }
      }

      _wasOffline = !hasConnection;
    }
  }

  /// Dispose the connectivity manager
  void dispose() {
    _connectivitySubscription.cancel();
    _listeners.clear();
  }

  /// Check if device has internet connectivity
  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }
}

/// Mixin for blocs that want to be notified of connectivity changes
mixin ConnectivityAwareMixin {
  bool _isRegistered = false;

  /// Register this bloc for connectivity notifications
  void registerForConnectivityUpdates() {
    if (!_isRegistered && this is ConnectivityAware) {
      GlobalConnectivityManager().registerListener(this as ConnectivityAware);
      _isRegistered = true;
    }
  }

  /// Unregister this bloc from connectivity notifications
  void unregisterFromConnectivityUpdates() {
    if (_isRegistered && this is ConnectivityAware) {
      GlobalConnectivityManager().unregisterListener(this as ConnectivityAware);
      _isRegistered = false;
    }
  }
}
