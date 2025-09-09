import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/obat_entity.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/assesment/obat_cubit.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_scrollable.dart';
import '../activitas/widget/circle_chart.dart';

class DashboardObatPage extends StatefulWidget {
  const DashboardObatPage({super.key});

  @override
  State<DashboardObatPage> createState() => _DashboardObatPageState();
}

class _DashboardObatPageState extends State<DashboardObatPage>
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

  Future<void> _onRefresh() async {
    // Implement your refresh logic here
    await context.read<ObatCubit>().getAllMedicine(
      DateTime.now().toIso8601String().split('T')[0],
    );
  }

  Widget _buttonHandler(ObatEntity obat) {
    // Parse dosis to get the total required count
    final dosisText = obat.dosis;
    final dosisMatch = RegExp(r'(\d+)').firstMatch(dosisText);
    final totalDosis = dosisMatch != null ? int.parse(dosisMatch.group(1)!) : 1;
    final currentCount = obat.count ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: currentCount > 0
                  ? () {
                      // Use the new decrement method
                      context.read<ObatCubit>().decrementDosage(obat);
                    }
                  : null,
              icon: Icon(
                Icons.remove_circle_outline,
                color: currentCount > 0 ? Colors.red : Colors.grey,
                size: 45,
              ),
            ),
            const Text('Lupa'),
          ],
        ),
        Column(
          children: [
            Text(
              '$currentCount/$totalDosis',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Diminum', style: TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: currentCount < totalDosis
                  ? () {
                      // Use the new increment method
                      context.read<ObatCubit>().incrementDosage(obat);
                    }
                  : null,
              icon: Icon(
                Icons.add_circle_outline,
                color: currentCount < totalDosis
                    ? ColorName.primary
                    : Colors.grey,
                size: 45,
              ),
            ),
            const Text('Sudah'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<ObatCubit, BaseState<List<ObatEntity>>>(
        builder: (context, state) {
          if (state.isError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text('Error: ${state.errorMessage}'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    textButton: 'Coba Lagi',
                    onTap: _onRefresh,
                  ),
                ),
              ],
            );
          } else if (state.isSuccess) {
            final obatList = state.data!;

            // Calculate progress based on dosage counts
            int totalDosisRequired = 0;
            int totalDosisTaken = 0;

            for (final obat in obatList) {
              // Parse dosis to get the total required count
              final dosisText = obat.dosis;
              final dosisMatch = RegExp(r'(\d+)').firstMatch(dosisText);
              final requiredCount = dosisMatch != null
                  ? int.parse(dosisMatch.group(1)!)
                  : 1;
              final takenCount = obat.count ?? 0;

              totalDosisRequired += requiredCount;
              totalDosisTaken += takenCount;
            }

            final targetPercent = totalDosisRequired > 0
                ? (totalDosisTaken / totalDosisRequired).clamp(0.0, 1.0)
                : 0.0;

            _animation = Tween<double>(begin: 0, end: targetPercent).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOut),
            );
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  20.verticalSpace,
                  Text(
                    'SKRINING OBAT',
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  32.verticalSpace,
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return InkWell(
                        onTap: () {
                          sl<AppNavigator>().pushNamed(addObatPage);
                        },
                        child: CircleChart(
                          currentValue: totalDosisTaken,
                          progressValue: _animation.value,
                          title: 'Dosis Obat\nHarian',
                          unit: '$totalDosisTaken/$totalDosisRequired',
                        ),
                      );
                    },
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Obat',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        ...obatList.map((obat) {
                          // Parse dosis to get the total required count
                          final dosisText = obat.dosis;
                          final dosisMatch = RegExp(
                            r'(\d+)',
                          ).firstMatch(dosisText);
                          final totalDosis = dosisMatch != null
                              ? int.parse(dosisMatch.group(1)!)
                              : 1;
                          final currentCount = obat.count ?? 0;
                          final isCompleted = currentCount >= totalDosis;
                          String typeObat = 'Sebelum Makan';
                          if (obat.type == 1) {
                            typeObat = 'Saat Makan';
                          } else if (obat.type == 2) {
                            typeObat = 'Sesudah Makan';
                          }

                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .1),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(16.r),
                              color: isCompleted
                                  ? Colors.green[100]
                                  : Colors.blueGrey[150],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                children: [
                                  Text(
                                    obat.name,
                                    style: GoogleFonts.poppins(fontSize: 16.sp),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    typeObat,
                                    style: GoogleFonts.poppins(fontSize: 16.sp),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    '$currentCount dari $totalDosis dosis',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: isCompleted
                                          ? Colors.green
                                          : currentCount > 0
                                          ? Colors.orange
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  4.verticalSpace,
                                  Text(
                                    isCompleted
                                        ? 'Sudah lengkap'
                                        : currentCount > 0
                                        ? 'Sedang berjalan'
                                        : 'Belum diminum',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      color: isCompleted
                                          ? Colors.green
                                          : currentCount > 0
                                          ? Colors.orange
                                          : Colors.red,
                                    ),
                                  ),
                                  8.verticalSpace,
                                  _buttonHandler(obat),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  // Add bottom padding to ensure last item is visible
                  SizedBox(height: 80.h),
                ],
              ),
            );
          } else if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollable(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Tidak mempunyai data'),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      textButton: 'Buat Data Obat',
                      onTap: () {
                        sl<AppNavigator>().pushNamed(addObatPage);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
