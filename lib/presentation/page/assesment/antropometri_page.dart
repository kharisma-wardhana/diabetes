import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/base_state.dart';
import '../../../domain/entity/assesment/antropometri/antropometri_entity.dart';
import '../../../gen/colors.gen.dart';
import '../../bloc/assesment/antropometri_cubit.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../widget/base_page.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/custom_text_field.dart';

class AntropometriPage extends StatefulWidget {
  const AntropometriPage({super.key});

  @override
  State<AntropometriPage> createState() => _AntropometriPageState();
}

class _AntropometriPageState extends State<AntropometriPage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController stomachController = TextEditingController();
  final TextEditingController handController = TextEditingController();
  final TextEditingController jenisAktivitasController = TextEditingController(
    text: 'Sangat jarang berolahraga (1-3 kali per bulan)',
  );
  final _formKey = GlobalKey<FormState>();
  late final List<String> jenisAktivitas;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    jenisAktivitas = [
      'Sangat jarang berolahraga (1-3 kali per bulan)',
      'Jarang berolahraga (1-2 kali per minggu)',
      'Cukup aktif (3-5 kali per minggu)',
      'Aktif (setiap hari)',
    ];
    isLoading = false;
    final cubit = context.read<AntropometriCubit>();
    final isHasData = cubit.state.isSuccess && cubit.state.data != null;
    if (isHasData) {
      final antropometriEntity = cubit.state.data!;
      heightController.text = antropometriEntity.height.toString();
      weightController.text = antropometriEntity.weight.toString();
      stomachController.text = antropometriEntity.stomach.toString();
      handController.text = antropometriEntity.hand.toString();
      jenisAktivitasController.text =
          antropometriEntity.activity ??
          'Sangat jarang berolahraga (1-3 kali per bulan)';
      _updateCalculations();
    }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    stomachController.dispose();
    handController.dispose();
    jenisAktivitasController.dispose();
    isLoading = false;
    super.dispose();
  }

  void _updateCalculations() {
    final cubit = context.read<AntropometriCubit>();
    final authState = context.read<AuthBloc>().state;

    String? gender;
    if (authState.isSuccess) {
      gender = authState.data!.gender;
    }

    setState(() => isLoading = true);
    cubit.updateCalculations(
      height: double.tryParse(heightController.text),
      weight: double.tryParse(weightController.text),
      waistCircumference: double.tryParse(stomachController.text),
      armCircumference: double.tryParse(handController.text),
      gender: gender,
    );
    setState(() => isLoading = false);
  }

  void _handleSubmitData() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      context.read<AntropometriCubit>().addAntropometriData(
        AntropometriEntity(
          height: double.parse(heightController.text),
          weight: double.parse(weightController.text),
          stomach: double.parse(stomachController.text),
          hand: double.parse(handController.text),
          result: context.read<AntropometriCubit>().state.data?.result ?? 0,
          status: context.read<AntropometriCubit>().state.data?.status ?? "",
          activity: jenisAktivitasController.text,
          waistStatus:
              context.read<AntropometriCubit>().state.data?.waistStatus ?? "",
          armStatus:
              context.read<AntropometriCubit>().state.data?.armStatus ?? "",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(title: const Text('PROFIL KESEHATAN')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AntropometriCubit, BaseState<AntropometriEntity>>(
            listener: (context, state) {
              if (state.isSuccess &&
                  state.data != null &&
                  state.data?.activity != null) {
                // When antropometri data is successfully saved,
                // trigger the auth bloc to mark antropometri as complete
                context.read<AuthBloc>().add(const CompleteAntropometriEvent());
              } else if (state.isError) {
                // Handle error if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Terjadi kesalahan'),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              // Update loading state
              if (mounted) {
                setState(() {
                  isLoading = state.isLoading;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<AntropometriCubit, BaseState<AntropometriEntity>>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    8.verticalSpace,
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
                      controller: TextEditingController(
                        text: state.data?.status ?? "",
                      ),
                      labelText: 'Status IMT',
                      isReadOnly: true,
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      controller: stomachController,
                      labelText: 'Lingkar Perut',
                      suffixIcon: const Text('cm'),
                      infoText: state.data?.waistStatus ?? "",
                      infoTextColor:
                          (state.data?.waistStatus != null &&
                              state.data!.waistStatus!.toLowerCase().contains(
                                'normal',
                              ))
                          ? ColorName.darkGrey
                          : Colors.red,
                      validatorEmpty: 'Silahkan masukkan lingkar perut',
                      keyboardType: TextInputType.number,
                      onChanged: (_) {
                        _updateCalculations();
                      },
                    ),
                    8.verticalSpace,
                    CustomTextField(
                      controller: handController,
                      labelText: 'Lingkar Lengan',
                      infoText: state.data?.armStatus ?? "",
                      infoTextColor:
                          (state.data?.armStatus != null &&
                              state.data!.armStatus!.toLowerCase().contains(
                                'normal',
                              ))
                          ? ColorName.darkGrey
                          : Colors.red,
                      suffixIcon: const Text('cm'),
                      validatorEmpty: 'Silahkan masukkan lingkar lengan',
                      keyboardType: TextInputType.number,
                      onChanged: (_) {
                        _updateCalculations();
                      },
                    ),
                    8.verticalSpace,
                    const Text('Jenis Aktivitas yang sering dilakukan?'),
                    CustomDropdown(
                      controller: jenisAktivitasController,
                      items: jenisAktivitas,
                      onChanged: (val) {
                        setState(() {
                          jenisAktivitasController.text = val;
                        });
                      },
                    ),
                    16.verticalSpace,
                    CustomButton(
                      isLoading: isLoading,
                      onTap: _handleSubmitData,
                      textButton: "Simpan",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
