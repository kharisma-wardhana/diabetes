import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/activity/activity_bloc.dart';
import '../../../bloc/activity/activity_state.dart';

class DashboardActivityPage extends StatelessWidget {
  const DashboardActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              return state.map(
                initial: (_) => const Placeholder(),
                loading: (_) => const CircularProgressIndicator(),
                checkPermissions: (_) => const Text('Checking Permissions...'),
                permissionsGranted: (_) => const Text('Permissions Granted'),
                permissionsDenied: (_) => const Text('Permissions Denied'),
                planRegistered: (_) => const Text('Plan Registered'),
                planUpdated: (_) => const Text('Plan Updated'),
                syncCompleted: (_) => const Text('Sync Completed'),
                synchronizing: (_) => const Text('Synchronizing...'),
                success: (_) => const Placeholder(),
                empty: (_) => const Text('No Data'),
                error: (_) => const Text('Error'),
              );
            },
          ),
        ],
      ),
    );
  }
}
