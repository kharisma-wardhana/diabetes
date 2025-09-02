import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/base_state.dart';
import '../../../../core/constant.dart';
import '../../../../core/injector/service_locator.dart';
import '../../../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../../../domain/entity/user/user_entity.dart';
import '../../../bloc/assesment/gula_cubit.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_event.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_loading.dart';
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
    final type = gulaDarahPuasaController.text.isNotEmpty ? '0' : '1';
    context.read<GulaCubit>().addGula(
      DateTime.now().toIso8601String().split('T')[0],
      TimeOfDay.now().toString(),
      type,
      type == '0'
          ? gulaDarahPuasaController.text
          : gulaDarahSewaktuController.text,
    );
    final gulaDarahPuasa = gulaDarahPuasaController.text.isNotEmpty
        ? int.tryParse(gulaDarahPuasaController.text) ?? 0
        : 0;
    final gulaDarahSewaktu = gulaDarahSewaktuController.text.isNotEmpty
        ? int.tryParse(gulaDarahSewaktuController.text) ?? 0
        : 0;
    setState(() {
      isDiabetes = gulaDarahPuasa > 100 || gulaDarahSewaktu > 180;
    });
    context.read<AuthBloc>().add(
      UpdateTypeDiabetesEvent(isDiabetes ? typeDM : typeNormal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Gula Darah')),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
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
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    16.verticalSpace,
                    BlocListener<AuthBloc, BaseState<UserEntity>>(
                      listener: (context, state) {
                        if (mounted) {
                          setState(() => isLoading = state.isLoading);
                        }
                        if (state.isSuccess) {
                          sl<AppNavigator>().pushNamedAndRemoveUntil(
                            recommendationPage,
                            arguments: isDiabetes
                                ? recommendations['diabetes']!
                                : recommendations['normal']!,
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
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
