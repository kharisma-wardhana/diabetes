import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/base_state.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/injector/service_locator.dart';
import '../../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../../bloc/kalori/kalori_bloc.dart';
import '../../../../widget/custom_button.dart';
import '../../activitas/widget/circle_chart.dart';
import '../../activitas/widget/health_info_row.dart';

class KaloriData extends StatefulWidget {
  const KaloriData({super.key});

  @override
  State<KaloriData> createState() => _KaloriDataState();
}

class _KaloriDataState extends State<KaloriData>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

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
        Text(
          'SKRINING KALORI',
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        32.verticalSpace,
        BlocBuilder<KaloriBloc, BaseState<KaloriEntity>>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading data...'),
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

            final targetKalori = state.isSuccess
                ? state.data!.targetKalori ?? 0
                : 0;
            final totalKalori = state.isSuccess
                ? state.data!.total.split(' ')[0]
                : "0";
            final kekuranganKalori = targetKalori - int.parse(totalKalori);

            double targetPercent = (int.parse(totalKalori) / targetKalori)
                .clamp(0.0, 1.0);
            _animation = Tween<double>(begin: 0, end: targetPercent).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOut),
            );
            return Column(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return InkWell(
                      onTap: () => sl<AppNavigator>().pushNamed(kaloriPage),
                      child: CircleChart(
                        currentValue: int.parse(totalKalori),
                        progressValue: _animation.value,
                        title: 'Kebutuhan\nKalori',
                        unit: 'Kkal',
                      ),
                    );
                  },
                ),
                32.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    textButton: 'Input Makanan',
                    onTap: () {
                      sl<AppNavigator>().pushNamed(dietPage);
                    },
                  ),
                ),
                18.verticalSpace,
                HealthInfoRow(
                  icon: Icons.food_bank_rounded,
                  label: "Target Kalori",
                  value: "$targetKalori Kkal",
                ),
                HealthInfoRow(
                  icon: Icons.food_bank_rounded,
                  label: "Total Kalori",
                  value: "$totalKalori Kkal",
                ),
                HealthInfoRow(
                  icon: Icons.food_bank_rounded,
                  label: "Jumlah Kalori yang dibutuhkan",
                  value: "$kekuranganKalori Kkal",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
