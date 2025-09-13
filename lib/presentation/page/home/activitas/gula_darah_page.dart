import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../../bloc/assesment/gula_cubit.dart';
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
      Fluttertoast.showToast(
        msg: 'Harap isi minimal salah satu nilai gula darah',
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    final type = gulaDarahPuasaController.text.isNotEmpty ? '0' : '1';
    final value = type == '0'
        ? gulaDarahPuasaController.text
        : gulaDarahSewaktuController.text;

    // Validate that the value is a valid number
    if (double.tryParse(value) == null) {
      Fluttertoast.showToast(
        msg: 'Nilai gula darah harus berupa angka yang valid',
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
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
    final timeNow = TimeOfDay.now();
    final currentDate = DateTime.now().toIso8601String().split('T')[0];
    final formattedTime = '${timeNow.hour}:${timeNow.minute.toString().padLeft(2, '0')}';
    context.read<GulaCubit>().addGula(
      currentDate,
      formattedTime,
      type,
      value,
    );
  }

  void _updateTypeDiabetesAndNavigate() async {
    try {
      await sl<FlutterSecureStorage>().write(
        key: typeDiabetesKey,
        value: isDiabetes ? typeDM.toString() : typeNormal.toString(),
      );

      // Add a small delay to ensure AuthBloc processes the event
      await Future.delayed(const Duration(milliseconds: 100));

      // Navigate to recommendation page
      sl<AppNavigator>().pushNamed(
        recommendationPage,
        arguments: isDiabetes
            ? recommendations['diabetes']!
            : recommendations['normal']!,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan: ${e.toString()}',
        textColor: Colors.white,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
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
                    state.errorMessage?.toString() ?? 'Unknown Error',
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            16.verticalSpace,
            BlocListener<GulaCubit, BaseState<List<GulaDarahEntity>>>(
              listener: (context, state) {
                if (mounted) {
                  setState(() => isLoading = state.isLoading);
                }
                if (state.isSuccess) {
                  // Update AuthBloc and navigate directly
                  _updateTypeDiabetesAndNavigate();
                } else if (state.isError) {
                  Fluttertoast.showToast(
                    msg: state.errorMessage?.toString() ?? "Unknown Error",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
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
