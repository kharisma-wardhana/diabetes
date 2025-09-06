import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/assesment_entity.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/assesment/assesment_cubit.dart';
import '../../../bloc/info/article_cubit.dart';
import '../../../bloc/info/doctor_cubit.dart';
import '../../../bloc/info/video_cubit.dart';
import '../../../widget/custom_loading.dart';
import 'widget/custom_button_info.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isLoading = false;
  String? errorMessage;
  final doctorCubit = sl<DoctorCubit>();
  final articleCubit = sl<ArticleCubit>();
  final videoCubit = sl<VideoCubit>();
  final navigatorHelper = sl<AppNavigator>();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    await context.read<AssesmentCubit>().getAssesment();
                  },
                  child:
                      BlocConsumer<AssesmentCubit, BaseState<AssesmentEntity>>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Container(
                              width: double.infinity,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: ColorName.primary,
                                  width: 2,
                                ),
                                boxShadow: List.of([
                                  BoxShadow(
                                    color: Colors.white12.withValues(
                                      alpha: 0.5,
                                    ),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ]),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    Assets.images.cekKesehatan.path,
                                    height: 60.h,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "CHECK KESEHATAN",
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.sp,
                                      color: ColorName.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        listener: (context, state) {
                          if (mounted) {
                            setState(() => isLoading = state.isLoading);
                          }
                          if (state.isError) {
                            Fluttertoast.showToast(
                              msg: state.errorMessage ?? "Unknown Error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
                          if (state.isSuccess && state.data != null) {
                            navigatorHelper.pushNamed(assesmentPage);
                          }
                        },
                      ),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonInfo(
                        icon: Assets.images.a13840231.path,
                        label: 'Ruang\nKonsultasi',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await doctorCubit.getAllDoctor();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(doctorPage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat data dokter';
                            });
                            _showErrorDialog('Gagal memuat data dokter');
                          }
                        },
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: CustomButtonInfo(
                        icon: Assets.images.informasiDiabetes.path,
                        label: 'Informasi\nDiabetes',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await articleCubit.getAllArticle();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(articlePage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat artikel';
                            });
                            _showErrorDialog('Gagal memuat artikel');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonInfo(
                        icon: Assets.images.icon.path,
                        label: 'Video\nEdukasi',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await videoCubit.getAllVideo();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(videoPage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat video';
                            });
                            _showErrorDialog('Gagal memuat video');
                          }
                        },
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: CustomButtonInfo(
                        icon: Assets.images.edukasiBencana.path,
                        label: 'Edukasi\nBencana',
                        onTap: () {
                          navigatorHelper.pushNamed(edukasiPage);
                        },
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
              ],
            ),
          ),
        ),
        if (isLoading) CustomLoading(),
      ],
    );
  }
}
