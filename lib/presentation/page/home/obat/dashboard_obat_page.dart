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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ObatCubit>().updateStatusMedicine(obat.id!, 0);
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.red,
                size: 45,
              ),
            ),
            const Text('Lupa'),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<ObatCubit>().updateStatusMedicine(obat.id!, 1);
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: ColorName.primary,
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
            final obatTaken = obatList.where((e) => e.status == 1).length;
            final obatGoal = obatList.length;
            final targetPercent = (obatTaken / obatGoal).clamp(0.0, 1.0);
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
                          currentValue: obatTaken,
                          progressValue: _animation.value,
                          title: 'Kebutuhan\nObat',
                          unit: '',
                        ),
                      );
                    },
                  ),
                  16.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: obatList.length > 1
                                ? 300
                                      .h // Limit height if more than 4 items
                                : double.infinity,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: obatList.length > 4
                                ? const AlwaysScrollableScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                            itemCount: obatList.length,
                            itemBuilder: (context, index) {
                              final obat = obatList[index];
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
                                  color: Colors.blueGrey[150],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    children: [
                                      Text(
                                        obat.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      4.verticalSpace,
                                      Text(
                                        obat.dosis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      8.verticalSpace,
                                      _buttonHandler(obat),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
