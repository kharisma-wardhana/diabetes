import 'package:diabetes/core/base_state.dart';
import 'package:diabetes/presentation/bloc/kalori/kalori_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/kalori/kalori_bloc.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';
import 'widget/activity_field.dart';

class KaloriPage extends StatefulWidget {
  const KaloriPage({super.key});

  @override
  State<KaloriPage> createState() => _KaloriPageState();
}

class _KaloriPageState extends State<KaloriPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController kaloriController = TextEditingController();
  final TextEditingController activityController = TextEditingController(
    text: 'Istirahat total / bedrest',
  );
  bool isLoading = false;

  void _updateCalculations() {
    final user = context.read<AuthBloc>().state.data;
    final height = double.tryParse(heightController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;
    final gender = user!.gender;

    if (height > 0 && weight > 0) {
      bmiController.text = context.read<KaloriBloc>().getBMIStatus(
        height,
        weight,
      );

      kaloriController.text = context.read<KaloriBloc>().calculateKalori(
        gender,
        height,
        weight,
        user.age!,
        double.tryParse(activityController.text) ?? 1.2,
      );
    } else {
      bmiController.text = '';
      kaloriController.text = '';
    }
  }

  void _handleSubmit() {
    context.read<KaloriBloc>().add(
      KaloriAddNutrition(
        KaloriEntity(
          date: DateTime.now().toIso8601String().split('T')[0],
          type: "0",
          name: "start",
          total: "0",
          targetKalori: int.parse(kaloriController.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(title: const Text('Kalori')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: heightController,
              labelText: 'Tinggi Badan',
              suffixIcon: const Text('cm'),
              keyboardType: TextInputType.number,
              validatorEmpty: 'Silahkan masukkan tinggi badan',
              onChanged: (_) {
                _updateCalculations();
              },
            ),
            8.verticalSpace,
            CustomTextField(
              controller: weightController,
              labelText: 'Berat Badan',
              suffixIcon: const Text('kg'),
              keyboardType: TextInputType.number,
              validatorEmpty: 'Silahkan masukkan berat badan',
              onChanged: (_) {
                _updateCalculations();
              },
            ),
            8.verticalSpace,
            CustomTextField(
              controller: bmiController,
              labelText: 'Status IMT',
              isReadOnly: true,
            ),
            8.verticalSpace,
            DropdownActivityField(activityController: activityController),
            8.verticalSpace,
            CustomTextField(
              controller: kaloriController,
              labelText: 'Kebutuhan Kalori',
              isReadOnly: true,
            ),
            16.verticalSpace,
            BlocListener<KaloriBloc, BaseState<KaloriEntity>>(
              listener: (context, state) {
                if (state.isSuccess) {
                  // Navigate to the next page or show a success message
                  final typeDiabetes = context
                      .read<AuthBloc>()
                      .state
                      .data
                      ?.typeDiabetes;
                  final args = context.read<KaloriBloc>().getTujuanDietArg(
                    typeDiabetes ?? typeNormal,
                    bmiController.text,
                  );
                  sl<AppNavigator>().pushNamed(tujuanDietPage, arguments: args);
                }
              },
              child: CustomButton(
                textButton: 'Lanjutkan',
                onTap: _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
