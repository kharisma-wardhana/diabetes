import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/base_state.dart';
import '../../../../../domain/entity/doctor/doctor_entity.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../bloc/info/doctor_cubit.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_loading.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  void _launch(String phone, BuildContext context) async {
    // Clean phone number (remove any non-digit characters except +)
    String cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // Encode the message
    String message = Uri.encodeComponent("Halo, saya ingin berkonsultasi");

    String url;
    if (Platform.isAndroid) {
      url = "https://wa.me/$cleanPhone?text=$message";
    } else {
      url = "https://api.whatsapp.com/send?phone=$cleanPhone&text=$message";
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: try opening WhatsApp app directly
        final fallbackUri = Uri.parse(
          "whatsapp://send?phone=$cleanPhone&text=$message",
        );
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        } else {
          Fluttertoast.showToast(
            msg: 'WhatsApp tidak tersedia atau tidak terinstall',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
    } catch (e) {
      // Show error message to user
      debugPrint('Error launching WhatsApp: $e');
      Fluttertoast.showToast(
        msg: 'Gagal membuka WhatsApp. Pastikan WhatsApp terinstall.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  // Preload images for better performance
  void _preloadImages(BuildContext context, List<DoctorEntity> doctors) {
    for (final doctor in doctors) {
      if (doctor.image.isNotEmpty) {
        precacheImage(NetworkImage(doctor.image), context);
      }
    }
  }

  // Simple image widget with built-in caching and error handling
  Widget _buildDoctorImage(BuildContext context, String imageUrl) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.network(
          imageUrl,
          width: 80.w,
          height: 80.h,
          fit: BoxFit.cover,
          // Built-in image caching with proper dimensions
          cacheWidth: (80.w * MediaQuery.of(context).devicePixelRatio).round(),
          cacheHeight: (80.h * MediaQuery.of(context).devicePixelRatio).round(),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 80.w,
              height: 80.h,
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorName.primary),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80.w,
              height: 80.h,
              color: Colors.grey[200],
              child: Icon(Icons.person, size: 40.sp, color: Colors.grey[400]),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('RUANG KONSULTASI')),
      body: BlocBuilder<DoctorCubit, BaseState<List<DoctorEntity>>>(
        builder: (context, state) {
          if (state.isSuccess) {
            // Preload images for better performance
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _preloadImages(context, state.data!);
            });

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      const Text(
                        'Jadwal Konsultasi',
                        textAlign: TextAlign.center,
                      ),
                      8.verticalSpace,
                      const Text(
                        'Senin - Jumat | Jam 08:00 - 17:00',
                        textAlign: TextAlign.center,
                      ),
                      16.verticalSpace,
                    ],
                  ),
                ),
                Expanded(
                  child: state.data!.isEmpty
                      ? const Center(
                          child: Text(
                            'Tidak ada dokter tersedia',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: state.data!.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                          itemBuilder: (context, index) {
                            final doctor = state.data![index];
                            return InkWell(
                              onTap: () => _launch(doctor.mobile, context),
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Doctor Image with constraints
                                    _buildDoctorImage(context, doctor.image),
                                    16.horizontalSpace,
                                    // Doctor Info with flexible constraints
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            doctor.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          4.verticalSpace,
                                          Text(
                                            doctor.position.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          8.verticalSpace,
                                          // Chat button
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: 6.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorName.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.chat,
                                                  color: Colors.white,
                                                  size: 16.sp,
                                                ),
                                                4.horizontalSpace,
                                                Text(
                                                  'Chat',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }
          if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: Colors.grey),
                  16.verticalSpace,
                  const Text(
                    'Something Went Wrong, Please Try Again Later',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
