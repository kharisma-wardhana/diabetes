import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../bloc/activity/activity_bloc.dart';
import '../../../bloc/activity/activity_event.dart';
import '../../../bloc/activity/activity_state.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/custom_loading.dart';
import '../../../widget/custom_text_field.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  TextEditingController activityController = TextEditingController(
    text: 'Berjalan Kaki',
  );
  TextEditingController activityLainController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isActivityLainSelected = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state here
    isActivityLainSelected = false; // Default to false
    isLoading = false; // Default loading state
  }

  @override
  void dispose() {
    activityController.dispose();
    activityLainController.dispose();
    super.dispose();
  }

  void _handleActivityInput() {
    if (_formKey.currentState!.validate()) {
      // Logic to handle activity input
      context.read<ActivityBloc>().add(
        RegisterActivityPlan(
          activityName: isActivityLainSelected
              ? activityLainController.text
              : activityController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktivitas')),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aktivitas Harian',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    CustomDropdown(
                      controller: activityController,
                      items: activityOptions,
                      onChanged: (value) {
                        // Handle dropdown selection
                        setState(() {
                          isActivityLainSelected = value == 'Lainnya';
                          if (!isActivityLainSelected) {
                            activityLainController.clear();
                          }
                        });
                      },
                    ),
                    16.verticalSpace,
                    isActivityLainSelected
                        ? CustomTextField(
                            labelText: 'Aktivitas Harian',
                            hintText: 'Masukkan Aktivitas Harian',
                            validatorEmpty:
                                'Aktivitas Harian tidak boleh kosong',
                            keyboardType: TextInputType.text,
                            controller: activityLainController,
                          )
                        : SizedBox.shrink(),
                    Spacer(),
                    BlocListener<ActivityBloc, ActivityState>(
                      listener: (context, state) {
                        if (mounted) {
                          setState(() {
                            isLoading = state.isLoading;
                          });
                        }
                        if (state.isSuccess) {
                          sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
                        } else if (state.isError) {
                          Fluttertoast.showToast(
                            msg: state.errorMessage ?? 'Unknown Error',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: CustomButton(
                        textButton: "Lanjutkan",
                        onTap: _handleActivityInput,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
