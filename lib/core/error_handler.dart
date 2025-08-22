import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GlobalErrorHandler {
  static void initialize() {
    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _logError(details.exception, details.stack, 'Flutter Framework Error');
      _showErrorToUser('App encountered an error. Please try again.');
    };

    // Handle errors outside of Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      _logError(error, stack, 'Platform Error');
      _showErrorToUser('Unexpected error occurred. Please restart the app.');
      return true;
    };

    // Handle async errors that weren't caught by widgets
    runZonedGuarded(
      () {
        // App initialization will happen here
      },
      (error, stackTrace) {
        _logError(error, stackTrace, 'Async Error');
        _showErrorToUser('Operation failed. Please try again.');
      },
    );
  }

  static void _logError(Object error, StackTrace? stackTrace, String source) {
    if (kDebugMode) {
      dev.log(
        'Error from $source: $error',
        error: error,
        stackTrace: stackTrace,
      );
    }

    // In production, you might want to send to crash reporting service
    // Example: Crashlytics.recordError(error, stackTrace);
  }

  static void _showErrorToUser(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  // Method to wrap potentially dangerous operations
  static T? runSafely<T>(T Function() operation, {String? errorMessage}) {
    try {
      return operation();
    } catch (e, stackTrace) {
      _logError(e, stackTrace, 'Safe Operation');
      if (errorMessage != null) {
        _showErrorToUser(errorMessage);
      }
      return null;
    }
  }

  // Async version of runSafely
  static Future<T?> runSafelyAsync<T>(
    Future<T> Function() operation, {
    String? errorMessage,
  }) async {
    try {
      return await operation();
    } catch (e, stackTrace) {
      _logError(e, stackTrace, 'Safe Async Operation');
      if (errorMessage != null) {
        _showErrorToUser(errorMessage);
      }
      return null;
    }
  }
}

// Error boundary widget for catching widget-specific errors
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext context, Object error)? errorBuilder;
  final void Function(Object error, StackTrace stackTrace)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? error;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return widget.errorBuilder?.call(context, error!) ??
          _defaultErrorWidget(context, error!);
    }

    // Use a FlutterError.onError override or try/catch in child widgets to catch errors.
    // Here, simply return the child; errors will be caught by FlutterError/onError.
    return widget.child;
  }

  Widget _defaultErrorWidget(BuildContext context, Object? error) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            kDebugMode ? error.toString() : 'Please try refreshing the page',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                error = null;
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// Safe widget wrapper
class SafeWidget extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Object error)? fallback;

  const SafeWidget({super.key, required this.child, this.fallback});

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(errorBuilder: fallback, child: child);
  }
}
