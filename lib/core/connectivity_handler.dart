import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityHandler {
  static final ConnectivityHandler _instance = ConnectivityHandler._internal();
  factory ConnectivityHandler() => _instance;
  ConnectivityHandler._internal();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isConnected = true;
  bool _hasShownDisconnectedMessage = false;

  // Initialize connectivity monitoring
  void initialize() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        debugPrint('Connectivity stream error: $error');
      },
    );

    // Check initial connectivity
    _checkInitialConnectivity();
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _onConnectivityChanged(result);
    } catch (e) {
      debugPrint('Error checking initial connectivity: $e');
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) async {
    bool hasConnection = false;

    for (var result in results) {
      if (result != ConnectivityResult.none) {
        hasConnection = await _hasInternetConnection();
        break;
      }
    }

    if (_isConnected != hasConnection) {
      _isConnected = hasConnection;

      if (!_isConnected && !_hasShownDisconnectedMessage) {
        _showConnectivityMessage('No internet connection', Colors.red);
        _hasShownDisconnectedMessage = true;
      } else if (_isConnected && _hasShownDisconnectedMessage) {
        _showConnectivityMessage('Internet connection restored', Colors.green);
        _hasShownDisconnectedMessage = false;
      }
    }
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  void _showConnectivityMessage(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
    );
  }

  // Public methods
  bool get isConnected => _isConnected;

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet);
  }

  Future<T?> executeWithConnectivity<T>(
    Future<T> Function() operation, {
    String? noConnectionMessage,
  }) async {
    if (!await checkConnectivity()) {
      _showConnectivityMessage(
        noConnectionMessage ??
            'No internet connection. Please check your network.',
        Colors.orange,
      );
      return null;
    }

    try {
      return await operation();
    } catch (e) {
      if (e is SocketException || e is TimeoutException) {
        _showConnectivityMessage(
          'Network error. Please check your connection.',
          Colors.red,
        );
      }
      rethrow;
    }
  }
}

// Widget that shows connectivity status
class ConnectivityAwareWidget extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext context)? noConnectionBuilder;

  const ConnectivityAwareWidget({
    super.key,
    required this.child,
    this.noConnectionBuilder,
  });

  @override
  State<ConnectivityAwareWidget> createState() =>
      _ConnectivityAwareWidgetState();
}

class _ConnectivityAwareWidgetState extends State<ConnectivityAwareWidget> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = !result.contains(ConnectivityResult.none);
      });
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return widget.noConnectionBuilder?.call(context) ??
          _defaultNoConnectionWidget(context);
    }
    return widget.child;
  }

  Widget _defaultNoConnectionWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please check your network settings',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Force refresh connectivity check
                ConnectivityHandler()._checkInitialConnectivity();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
