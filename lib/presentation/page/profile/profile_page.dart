import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/base_state.dart';
import '../../../core/constant.dart';
import '../../../core/injector/service_locator.dart';
import '../../../domain/entity/user/user_entity.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../widget/base_page.dart';
import '../../widget/custom_button.dart';
import 'widget/profile_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  void _handleLogout() {
    context.read<AuthBloc>().add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('PROFILE')),
      isLoading: isLoading,
      body: BlocConsumer<AuthBloc, BaseState<UserEntity>>(
        listener: (context, state) {
          if (mounted) {
            setState(() {
              isLoading = state.isLoading;
            });
          }
          if (state.isError) {
            Fluttertoast.showToast(
              msg: state.errorMessage ?? 'Error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
          if (state.isInitial) {
            sl<AppNavigator>().pushNamedAndRemoveUntil(loginPage);
          }
        },
        builder: (context, state) {
          if (state.isSuccess) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          ProfilData(title: 'Nama', content: state.data!.name),
                          ProfilData(
                            title: 'Jenis Kelamin',
                            content: state.data!.gender,
                          ),
                          ProfilData(
                            title: 'Tanggal Lahir',
                            content: state.data!.dob,
                          ),
                          ProfilData(
                            title: 'No Handphone',
                            content: state.data!.mobile,
                          ),
                          Expanded(
                            child: SizedBox(height: 20.h),
                          ), // This will push buttons to bottom
                          CustomButton(
                            textButton: 'Profile Kesehatan',
                            onTap: () {
                              sl<AppNavigator>().pushNamed(antropometriPage);
                            },
                          ),
                          8.verticalSpace,
                          CustomButton(
                            textButton: 'Tentang Aplikasi',
                            onTap: () {
                              sl<AppNavigator>().pushNamed(aboutPage);
                            },
                          ),
                          8.verticalSpace,
                          CustomButton(
                            textButton: 'LogOut',
                            onTap: _handleLogout,
                            buttonColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
