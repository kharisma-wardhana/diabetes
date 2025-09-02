import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../bloc/activity/activity_bloc.dart';
import '../../../bloc/activity/activity_event.dart';
import '../../../bloc/activity/activity_state.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_scrollable.dart';
import 'widget/health_data.dart';

class DashboardActivityPage extends StatefulWidget {
  const DashboardActivityPage({super.key});

  @override
  State<DashboardActivityPage> createState() => _DashboardActivityPageState();
}

class _DashboardActivityPageState extends State<DashboardActivityPage> {
  @override
  void initState() {
    super.initState();
    // Trigger initial data fetch
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<ActivityBloc>().add(const FetchActivityData());
    // });
  }

  Future<void> _onRefresh() async {
    context.read<ActivityBloc>().add(const RefreshActivityData());

    // Wait for the loading state to complete
    await Future.delayed(const Duration(milliseconds: 100));

    // Create a completer to wait for the state change
    final completer = Completer<void>();
    late StreamSubscription subscription;

    if (mounted) {
      subscription = context.read<ActivityBloc>().stream.listen((state) {
        if (!state.isLoading) {
          subscription.cancel();
          completer.complete();
        }
      });
    }

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        subscription.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inbox, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('Tidak mempunyai data'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    textButton: 'Buat Data Kesehatan',
                    onTap: () {
                      sl<AppNavigator>().pushNamed(questionPage);
                    },
                  ),
                ),
              ],
            ),
            empty: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inbox, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('Tidak mempunyai data'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    textButton: 'Buat Data Kesehatan',
                    onTap: () {
                      sl<AppNavigator>().pushNamed(questionPage);
                    },
                  ),
                ),
              ],
            ),
            loading: (_) => const CustomScrollable(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading health data...'),
                  ],
                ),
              ),
            ),
            checkPermissions: (_) => const CustomScrollable(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security, size: 64, color: Colors.orange),
                    SizedBox(height: 16),
                    Text('Checking permissions...'),
                  ],
                ),
              ),
            ),
            permissionsGranted: (_) => const CustomScrollable(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 64, color: Colors.green),
                    SizedBox(height: 16),
                    Text('Permissions granted'),
                  ],
                ),
              ),
            ),
            permissionsDenied: (_) => CustomScrollable(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text('Permissions denied'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ActivityBloc>().add(
                          const RequestAuthorization(),
                        );
                      },
                      child: const Text('Request Permissions'),
                    ),
                  ],
                ),
              ),
            ),
            success: (_) => const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: HealthData(),
            ),
            error: (err) => CustomScrollable(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${err.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ActivityBloc>().add(
                          const FetchActivityData(),
                        );
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
