import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../bloc/activity/activity_bloc.dart';
import '../../../../bloc/activity/activity_state.dart';
import 'circle_chart.dart';
import 'health_info_row.dart';

class HealthData extends StatefulWidget {
  const HealthData({super.key});

  @override
  State<HealthData> createState() => _HealthDataState();
}

class _HealthDataState extends State<HealthData>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final int currentValue = 150;
  final int stepsTaken = 4000;
  final int stepGoal = 5000;

  @override
  void initState() {
    super.initState();
    double targetPercent = (stepsTaken / stepGoal).clamp(0.0, 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _animation = Tween<double>(
      begin: 0,
      end: targetPercent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Column(
          children: [
            Image.asset(Assets.images.logoElan.path, height: 80.h),
            16.verticalSpace,
            Text(
              'SKRINING KESEHATAN',
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        32.verticalSpace,
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CircleChart(
              currentValue: currentValue,
              progressValue: _animation.value,
              title: 'Gula Darah',
              unit: 'mg/dL',
            );
          },
        ),
        24.verticalSpace,
        BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading health data...'),
                ],
              );
            }

            if (state.isError) {
              return Column(
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage ?? "Unknown error",
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add retry logic here if needed
                    },
                    child: const Text('Retry'),
                  ),
                ],
              );
            }

            final steps = state.isSuccess ? state.data!.steps : 0;
            final bloodPressure = state.isSuccess
                ? state.data!.bloodPressure
                : "-";
            final calories = 200;

            return Column(
              children: [
                HealthInfoRow(
                  icon: Icons.directions_walk,
                  label: "Jumlah Langkah Hari ini",
                  value: "$steps langkah",
                ),
                HealthInfoRow(
                  icon: Icons.monitor_heart,
                  label: "Tekanan Darah",
                  value: "$bloodPressure mmHg",
                ),
                HealthInfoRow(
                  icon: Icons.local_fire_department,
                  label: "Jumlah Kalori yang Terbakar",
                  value: "$calories kalori",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
