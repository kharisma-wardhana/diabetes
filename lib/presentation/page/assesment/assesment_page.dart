import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../core/base_state.dart';
import '../../../core/injector/service_locator.dart';
import '../../../domain/entity/assesment/assesment_entity.dart';
import '../../bloc/assesment/asam_urat_cubit.dart';
import '../../bloc/assesment/assesment_cubit.dart';
import '../../bloc/assesment/ginjal_cubit.dart';
import '../../bloc/assesment/gula_cubit.dart';
import '../../bloc/assesment/hb1ac_cubit.dart';
import '../../bloc/assesment/kolesterol_cubit.dart';
import '../../bloc/assesment/tensi_cubit.dart';
import '../../bloc/assesment/water_cubit.dart';
import '../../widget/custom_loading.dart';
import 'widget/custom_assesment_button.dart';

class AssesmentPage extends StatefulWidget {
  const AssesmentPage({super.key});

  @override
  State<AssesmentPage> createState() => _AssesmentPageState();
}

class _AssesmentPageState extends State<AssesmentPage> {
  bool isLoading = false;
  static final navigatorHelper = sl<AppNavigator>();
  static final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: BlocConsumer<AssesmentCubit, BaseState<AssesmentEntity>>(
                listener: (context, state) {
                  setState(() => isLoading = state.isLoading);
                },
                builder: (context, state) {
                  if (state.isSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHECK KESEHATAN',
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                        16.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Kadar Gula Darah',
                          data: [
                            'Total: ${state.data!.gula?.total}',
                            state.data!.gula?.type == 1
                                ? 'Jenis: Puasa'
                                : 'Jenis: Non Puasa',
                            'Tanggal: ${state.data!.gula?.date}',
                          ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<GulaCubit>().getListGula(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(gulaPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Tekanan Darah',
                          data: state.data!.tensi == null
                              ? [
                                  'Belum ada data tekanan darah',
                                  'Silakan cek tekanan darah Anda terlebih dahulu.',
                                ]
                              : [
                                  'Tensi: ${state.data!.tensi?.sistole} / ${state.data!.tensi?.diastole}',
                                  'Tanggal: ${state.data!.tensi?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<TensiCubit>().getListTensi(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(tensiPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'HbA1c',
                          data: state.data!.hb1ac == null
                              ? [
                                  'Belum ada data HbA1c',
                                  'Silakan cek HbA1c Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.data!.hb1ac?.total}',
                                  'Tanggal: ${state.data!.hb1ac?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<Hb1acCubit>().getListHb(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(hbPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Konsumsi Air',
                          data: state.data!.water == null
                              ? [
                                  'Belum ada data konsumsi air',
                                  'Silakan cek konsumsi air Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.data!.water?.total}',
                                  'Target: ${state.data!.water?.target}',
                                  'Tanggal: ${state.data!.water?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<WaterCubit>().getAllWater(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(waterPage);
                          },
                        ),
                        CustomAssesmentButton(
                          title: 'Asam Urat',
                          data: state.data!.asamUrat == null
                              ? [
                                  'Belum ada data asam urat',
                                  'Silakan cek asam urat Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.data!.asamUrat?.total}',
                                  'Tanggal: ${state.data!.asamUrat?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<AsamUratCubit>().getListAsamUrat(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(asamUratPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Kadar Kolesterol',
                          data: state.data!.kolesterol == null
                              ? [
                                  'Belum ada data kolesterol',
                                  'Silakan cek kadar kolesterol Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.data!.kolesterol?.total}',
                                  'Jenis: ${state.data!.kolesterol?.type}',
                                  'Tanggal: ${state.data!.kolesterol?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context
                                .read<KolesterolCubit>()
                                .getListKolesterol(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(kolesterolPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Check Ureum & Kreatinin',
                          data: state.data!.ginjal == null
                              ? [
                                  'Belum ada data ginjal',
                                  'Silakan cek kesehatan ginjal Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.data!.ginjal?.total}',
                                  state.data!.ginjal?.type == 1
                                      ? 'Jenis: Ureum'
                                      : 'Jenis: Kreatinin',
                                  'Tanggal: ${state.data!.ginjal?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<GinjalCubit>().getListGinjal(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(ginjalPage);
                          },
                        ),
                        16.verticalSpace,
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
