import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../bloc/kalori/kalori_bloc.dart';
import '../../../bloc/kalori/kalori_event.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_dropdown.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  TextEditingController karbohidratController = TextEditingController(
    text: 'Nasi Merah 150 gr (1 mangkok kecil) (200 kkal)',
  );
  TextEditingController proteinController = TextEditingController(
    text: 'Telur rebus 1 butir (90 kkal)',
  );
  TextEditingController seratController = TextEditingController(
    text: 'Sayur bayam 1 mangkuk (40 kkal)',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Perencanaan Diet')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 8.r),
                  children: [
                    Text(
                      'Karbohidrat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: karbohidratController,
                      items: karboOptions,
                      onChanged: (val) {
                        karbohidratController.text = val;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      'Protein dan Lemak Sehat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: proteinController,
                      items: proteinOptions,
                      onChanged: (val) {
                        proteinController.text = val;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      'Serat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: seratController,
                      items: seratOptions,
                      onChanged: (val) {
                        seratController.text = val;
                      },
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
              BlocBuilder<KaloriBloc, BaseState<KaloriEntity>>(
                builder: (context, state) {
                  if (state.isSuccess) {
                    sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
                  }
                  return CustomButton(
                    textButton: "Lanjutkan",
                    onTap: () {
                      final now = DateTime.now().toIso8601String().split(
                        'T',
                      )[0];
                      context.read<KaloriBloc>().add(
                        KaloriAddNutrition(
                          KaloriEntity(
                            date: now,
                            type: "0",
                            name: "name",
                            total: "0",
                            targetKalori: 100,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
