// Example of how to use ActivityState with BaseState-like functionality
// and custom activity-specific states and events

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_bloc.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityPageExample extends StatelessWidget {
  const ActivityPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Example'),
        actions: [
          IconButton(
            onPressed: () => context.read<ActivityBloc>().add(
              const ActivityEvent.refreshData(),
            ),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocConsumer<ActivityBloc, ActivityState>(
        listener: (context, state) {
          // Handle state changes with custom activity states
          state.maybeWhen(
            permissionsGranted: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Permissions granted!')),
              );
            },
            permissionsDenied: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Permissions denied')),
              );
            },
            planRegistered: (planId, message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Plan $planId registered: $message')),
              );
            },
            syncCompleted: (lastSync, message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sync completed at $lastSync')),
              );
            },
            error: (message, error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $message'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              // Status indicators using BaseState-like properties
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('State Status:'),
                      const SizedBox(height: 8),
                      _buildStatusChips(state),
                      if (state.message != null) ...[
                        const SizedBox(height: 8),
                        Text('Message: ${state.message}'),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons for different events
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionButton(
                      context,
                      'Fetch Data',
                      Icons.download,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.fetchData(),
                      ),
                    ),
                    _buildActionButton(
                      context,
                      'Check Permissions',
                      Icons.security,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.checkPermissions(),
                      ),
                    ),
                    _buildActionButton(
                      context,
                      'Register Plan',
                      Icons.add_chart,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.registerPlan(
                          planType: 'daily_exercise',
                          planData: {'duration': 30, 'type': 'cardio'},
                        ),
                      ),
                    ),
                    _buildActionButton(
                      context,
                      'Start Sync',
                      Icons.sync,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.startSync(),
                      ),
                    ),
                    _buildActionButton(
                      context,
                      'Start Tracking',
                      Icons.play_circle,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.startTracking(
                          activityType: 'running',
                        ),
                      ),
                    ),
                    _buildActionButton(
                      context,
                      'Clear Data',
                      Icons.clear,
                      () => context.read<ActivityBloc>().add(
                        const ActivityEvent.clearData(),
                      ),
                    ),
                  ],
                ),
              ),

              // Data display area
              if (state.isSuccess && state.data != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Health Data:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Data: ${state.data}'),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusChips(ActivityState state) {
    return Wrap(
      spacing: 8,
      children: [
        if (state.isInitial) _buildStatusChip('Initial', Colors.grey),
        if (state.isLoading) _buildStatusChip('Loading', Colors.blue),
        if (state.isSuccess) _buildStatusChip('Success', Colors.green),
        if (state.isError) _buildStatusChip('Error', Colors.red),
        if (state.isEmpty) _buildStatusChip('Empty', Colors.orange),
        if (state.isCheckingPermissions)
          _buildStatusChip('Checking Permissions', Colors.purple),
        if (state.arePermissionsGranted)
          _buildStatusChip('Permissions OK', Colors.green),
        if (state.arePermissionsDenied)
          _buildStatusChip('Permissions Denied', Colors.red),
        if (state.isPlanRegistered)
          _buildStatusChip('Plan Registered', Colors.teal),
        if (state.isPlanUpdated) _buildStatusChip('Plan Updated', Colors.cyan),
        if (state.isSynchronizing) _buildStatusChip('Syncing', Colors.indigo),
        if (state.isSyncCompleted)
          _buildStatusChip('Sync Complete', Colors.lime),
      ],
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// Extension methods to demonstrate additional BaseState-like functionality
extension ActivityStateHelpers on ActivityState {
  /// Check if the state represents any kind of in-progress operation
  bool get isInProgress =>
      isLoading || isCheckingPermissions || isSynchronizing;

  /// Check if the state represents a completed operation
  bool get isCompleted =>
      isSuccess || isPlanRegistered || isPlanUpdated || isSyncCompleted;

  /// Check if the state represents a failure condition
  bool get isFailure => isError || arePermissionsDenied;

  /// Get a user-friendly status message
  String get statusMessage {
    return when(
      initial: () => 'Ready to start',
      loading: (message) => message ?? 'Loading...',
      success: (data, message) => message ?? 'Operation completed successfully',
      error: (message, error, stackTrace) => message,
      empty: (message) => message ?? 'No data available',
      checkPermissions: () => 'Checking permissions...',
      permissionsGranted: () => 'All permissions granted',
      permissionsDenied: () => 'Some permissions were denied',
      planRegistered: (planId, message) =>
          message ?? 'Plan registered: $planId',
      planUpdated: (planId, message) => message ?? 'Plan updated: $planId',
      synchronizing: (message) => message ?? 'Synchronizing data...',
      syncCompleted: (lastSync, message) =>
          message ?? 'Sync completed at $lastSync',
    );
  }
}
