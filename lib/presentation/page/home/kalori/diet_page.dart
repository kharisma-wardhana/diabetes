import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../../gen/colors.gen.dart';
import '../../../bloc/kalori/kalori_bloc.dart';
import '../../../bloc/kalori/kalori_event.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_dropdown.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  final TextEditingController karbohidratController = TextEditingController(
    text: '-',
  );
  final TextEditingController proteinController = TextEditingController(
    text: '-',
  );
  final TextEditingController seratController = TextEditingController(
    text: '-',
  );
  int totalKalori = 0;
  bool isLoading = false;

  // Track previous values to enable subtraction
  String _previousKarbohidrat = '-';
  String _previousProtein = '-';
  String _previousSerat = '-';

  void _updateKalori(String val, String category) {
    setState(() {
      // Extract calories from the value
      int getCaloriesFromValue(String value) {
        if (value == '-') return 0;
        final regex = RegExp(r'\((\d+)\s*kkal\)');
        final match = regex.firstMatch(value);
        return match != null ? int.parse(match.group(1)!) : 0;
      }

      // Get previous value based on category
      String previousValue;
      switch (category) {
        case 'karbohidrat':
          previousValue = _previousKarbohidrat;
          _previousKarbohidrat = val;
          break;
        case 'protein':
          previousValue = _previousProtein;
          _previousProtein = val;
          break;
        case 'serat':
          previousValue = _previousSerat;
          _previousSerat = val;
          break;
        default:
          previousValue = '-';
      }

      // Subtract previous calories and add new calories
      int previousCalories = getCaloriesFromValue(previousValue);
      int newCalories = getCaloriesFromValue(val);

      totalKalori = totalKalori - previousCalories + newCalories;

      // Ensure totalKalori doesn't go below 0
      if (totalKalori < 0) {
        totalKalori = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(title: const Text('Input Makanan')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      _updateKalori(val, 'karbohidrat');
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
                      _updateKalori(val, 'protein');
                      proteinController.text = val;
                    },
                  ),
                  16.verticalSpace,
                  Text('Serat', style: TextStyle(fontWeight: FontWeight.bold)),
                  8.verticalSpace,
                  CustomDropdown(
                    controller: seratController,
                    items: seratOptions,
                    onChanged: (val) {
                      _updateKalori(val, 'serat');
                      seratController.text = val;
                    },
                  ),
                  32.verticalSpace,
                  const Text(
                    'Total Kalori',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  8.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      '$totalKalori kkal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorName.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<KaloriBloc, BaseState<KaloriEntity>>(
              listener: (context, state) {
                if (mounted) {
                  setState(() {
                    isLoading = state.isLoading;
                  });
                }
                if (state.isSuccess) {
                  sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
                }
              },
              child: CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  final now = DateTime.now().toIso8601String().split('T')[0];
                  context.read<KaloriBloc>().add(
                    KaloriAddNutrition(
                      KaloriEntity(
                        date: now,
                        type: "0",
                        name:
                            "${karbohidratController.text}, "
                            "${proteinController.text}, "
                            "${seratController.text}",
                        total: totalKalori.toString(),
                        targetKalori:
                            context
                                .read<KaloriBloc>()
                                .state
                                .data
                                ?.targetKalori ??
                            0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
