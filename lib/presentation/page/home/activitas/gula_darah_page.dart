import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../../bloc/assesment/gula_cubit.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_event.dart';
import '../../../widget/base_page.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';

class GulaDarahPage extends StatefulWidget {
  const GulaDarahPage({super.key});

  @override
  State<GulaDarahPage> createState() => _GulaDarahPageState();
}

class _GulaDarahPageState extends State<GulaDarahPage> {
  final _formKey = GlobalKey<FormState>();
  bool isDiabetes = false;
  bool isLoading = false;
  TextEditingController gulaDarahPuasaController = TextEditingController();
  TextEditingController gulaDarahSewaktuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isDiabetes = false; // Initialize to false, change based on logic
    isLoading = false; // Initialize loading state
  }

  @override
  void dispose() {
    isDiabetes = false; // Reset the state when disposing
    isLoading = false; // Reset loading state
    gulaDarahPuasaController.dispose();
    gulaDarahSewaktuController.dispose();
    super.dispose();
  }

  void _handleNextButton() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    // Custom validation: at least one field must have a value
    if (gulaDarahPuasaController.text.isEmpty &&
        gulaDarahSewaktuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi minimal salah satu nilai gula darah'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final type = gulaDarahPuasaController.text.isNotEmpty ? '0' : '1';
    final value = type == '0'
        ? gulaDarahPuasaController.text
        : gulaDarahSewaktuController.text;

    // Validate that the value is a valid number
    if (double.tryParse(value) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nilai gula darah harus berupa angka yang valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Calculate diabetes status for later use
    final gulaDarahPuasa = gulaDarahPuasaController.text.isNotEmpty
        ? int.tryParse(gulaDarahPuasaController.text) ?? 0
        : 0;
    final gulaDarahSewaktu = gulaDarahSewaktuController.text.isNotEmpty
        ? int.tryParse(gulaDarahSewaktuController.text) ?? 0
        : 0;
    setState(() {
      isDiabetes = gulaDarahPuasa > 100 || gulaDarahSewaktu > 180;
    });

    // Add gula data first, AuthBloc will be updated in the listener if successful
    context.read<GulaCubit>().addGula(
      DateTime.now().toIso8601String().split('T')[0],
      TimeOfDay.now().toString().split('(')[1].split(')')[0],
      type,
      value,
    );
  }

  void _updateTypeDiabetesAndNavigate() async {
    try {
      print(
        'Updating AuthBloc with typeDiabetes: ${isDiabetes ? typeDM : typeNormal}',
      );

      // Update AuthBloc
      context.read<AuthBloc>().add(
        UpdateTypeDiabetesEvent(isDiabetes ? typeDM : typeNormal),
      );

      // Add a small delay to ensure AuthBloc processes the event
      await Future.delayed(const Duration(milliseconds: 100));

      print('Navigating to recommendation page...');

      // Navigate to recommendation page
      sl<AppNavigator>().pushNamed(
        recommendationPage,
        arguments: isDiabetes
            ? recommendations['diabetes']!
            : recommendations['normal']!,
      );
    } catch (e) {
      print('Error in _updateTypeDiabetesAndNavigate: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('Gula Darah')),
      isLoading: isLoading,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              labelText: 'Gula Darah Puasa',
              hintText: 'Masukkan Gula Darah Puasa',
              keyboardType: TextInputType.number,
              controller: gulaDarahPuasaController,
              satuanText: 'mg/dL',
              validatorEmpty: 'Gula Darah Puasa tidak boleh kosong',
              disableValidation: true,
            ),
            16.verticalSpace,
            CustomTextField(
              labelText: 'Gula Darah Sewaktu',
              hintText: 'Masukkan Gula Darah Sewaktu',
              keyboardType: TextInputType.number,
              controller: gulaDarahSewaktuController,
              satuanText: 'mg/dL',
              validatorEmpty: 'Gula Darah Sewaktu tidak boleh kosong',
              disableValidation: true,
            ),
            16.verticalSpace,
            BlocBuilder<GulaCubit, BaseState<List<GulaDarahEntity>>>(
              builder: (context, state) {
                if (state.isError) {
                  return Text(
                    state.errorMessage ?? 'Unknown Error',
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            16.verticalSpace,
            BlocListener<GulaCubit, BaseState<List<GulaDarahEntity>>>(
              listener: (context, state) {
                print('GulaCubit listener triggered: ${state.runtimeType}');
                print('GulaCubit isSuccess: ${state.isSuccess}');
                print('GulaCubit isError: ${state.isError}');
                print('GulaCubit isLoading: ${state.isLoading}');

                if (mounted) {
                  setState(() => isLoading = state.isLoading);
                }
                if (state.isSuccess) {
                  print(
                    'GulaCubit success - updating AuthBloc with isDiabetes: $isDiabetes',
                  );

                  // Update AuthBloc and navigate directly
                  _updateTypeDiabetesAndNavigate();
                } else if (state.isError) {
                  print('GulaCubit error: ${state.errorMessage}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal menyimpan data: ${state.errorMessage}',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: CustomButton(
                textButton: "Lanjutkan",
                onTap: _handleNextButton,
              ),
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
