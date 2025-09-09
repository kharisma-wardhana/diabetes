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
import '../../../bloc/assesment/gula_cubit.dart';
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
  TextEditingController activityController = TextEditingController(text: '-');
  TextEditingController activityLainController = TextEditingController();
  TextEditingController stepController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isActivityLainSelected = false;
  bool isStepValid = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state here
    isActivityLainSelected = false; // Default to false
    isLoading = false; // Default loading state
    isStepValid = false;
  }

  @override
  void dispose() {
    activityController.dispose();
    activityLainController.dispose();
    isStepValid = false;
    isLoading = false;
    super.dispose();
  }

  void _handleActivityInput() async {
    if (_formKey.currentState!.validate() && activityController.text != '-') {
      try {
        // Fetch latest blood sugar data first
        final today = DateTime.now().toIso8601String().split('T')[0];
        await context.read<GulaCubit>().getListGula(today);

        if (!mounted) return;

        // Get the latest blood sugar value
        final bloodSugarValue = context
            .read<GulaCubit>()
            .getLatestBloodSugarValue();

        // Logic to handle activity input with blood sugar value
        context.read<ActivityBloc>().add(
          RegisterActivityPlan(
            activityName: isActivityLainSelected
                ? activityLainController.text
                : activityController.text,
            planData: {'target_steps': stepController.text},
            bloodSugar: bloodSugarValue,
          ),
        );
      } catch (e) {
        if (!mounted) return;

        // If there's an error fetching blood sugar, proceed without it
        context.read<ActivityBloc>().add(
          RegisterActivityPlan(
            activityName: isActivityLainSelected
                ? activityLainController.text
                : activityController.text,
            planData: {'target_steps': stepController.text},
          ),
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Harap pilih aktivitas dan lengkapi form yang diperlukan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
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
                      'Silahkan pilih aktivitas hari ini yang ingin anda lakukan',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    CustomDropdown(
                      controller: activityController,
                      items: activityOptions,
                      onChanged: (String value) {
                        // Handle dropdown selection
                        setState(() {
                          activityController.text = value;
                          isActivityLainSelected = value == 'Lainnya';
                          isStepValid =
                              value.toLowerCase().contains('jalan') ||
                              value.toLowerCase().contains('jogging') ||
                              value.toLowerCase().contains('lari');
                          if (isStepValid) {
                            stepController.text = '5000';
                          }
                          if (!isActivityLainSelected) {
                            activityLainController.clear();
                          }
                        });
                      },
                    ),
                    16.verticalSpace,
                    isStepValid
                        ? CustomTextField(
                            labelText: 'Target Langkah Harian',
                            hintText: 'Masukkan Target Langkah Harian',
                            validatorEmpty:
                                'Target Langkah Harian tidak boleh kosong',
                            keyboardType: TextInputType.number,
                            controller: stepController,
                          )
                        : SizedBox.shrink(),
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
                          sl<AppNavigator>().pushNamedAndRemoveUntil(
                            homePage,
                            arguments: 1,
                          );
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
