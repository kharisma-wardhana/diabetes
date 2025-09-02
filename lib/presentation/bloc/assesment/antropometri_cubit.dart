import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/base_state.dart';
import '../../../core/constant.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/antropometri/antropometri_entity.dart';
import '../../../domain/usecase/assesment/antropometri/add_antropometri_usecase.dart';
import '../../../domain/usecase/assesment/antropometri/get_antropometri_usecase.dart';

class AntropometriCubit extends Cubit<BaseState<AntropometriEntity>> {
  final AddAntropometriUseCase addAntropometriUseCase;
  final GetAntropometriUseCase getAntropometriUseCase;
  final FlutterSecureStorage secureStorage;

  AntropometriCubit({
    required this.addAntropometriUseCase,
    required this.getAntropometriUseCase,
    required this.secureStorage,
  }) : super(BaseState.initial());

  // Method to update calculations based on input changes
  void updateCalculations({
    double? height,
    double? weight,
    double? waistCircumference,
    double? armCircumference,
    String? gender,
  }) {
    double currentHeight = height ?? 0;
    double currentWeight = weight ?? 0;
    double currentWaist = waistCircumference ?? 0;
    double currentArm = armCircumference ?? 0;

    // Calculate BMI
    double bmi = calculateBMI(currentHeight, currentWeight);
    String bmiStatus = getBMIStatus(bmi);

    // Calculate arm status
    String armStatus = currentArm > 0
        ? getArmCircumferenceStatus(currentArm)
        : '';

    // Calculate waist status
    String waistStatus = currentWaist > 0 && gender != null
        ? getWaistCircumferenceStatus(currentWaist, gender)
        : '';

    emit(
      BaseState.success(
        data: AntropometriEntity(
          height: currentHeight,
          weight: currentWeight,
          stomach: currentWaist,
          hand: currentArm,
          result: bmi,
          status: bmiStatus,
          armStatus: armStatus,
          waistStatus: waistStatus,
        ),
      ),
    );
  }

  String getArmCircumferenceStatus(double armCircumference) {
    if (armCircumference < 21) {
      return 'Malnutrisi';
    }
    return 'Normal';
  }

  String getWaistCircumferenceStatus(double waistCircumference, String gender) {
    if (gender.toLowerCase().contains('laki-laki')) {
      return waistCircumference > 90 ? 'Obesitas Sentral' : 'Normal';
    } else if (gender.toLowerCase().contains('wanita')) {
      return waistCircumference > 80 ? 'Obesitas Sentral' : 'Normal';
    }
    return 'Normal';
  }

  double calculateBMI(double height, double weight) {
    if (height <= 0 || weight <= 0) return 0;
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return '${bmi.toStringAsFixed(2)} (Kurus)';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return '${bmi.toStringAsFixed(2)} (Normal)';
    } else {
      return '${bmi.toStringAsFixed(2)} (Obesitas)';
    }
  }

  void addAntropometriData(AntropometriEntity data) async {
    emit(BaseState.loading());
    try {
      final response = await addAntropometriUseCase.call(AddParams(data: data));

      return response.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) async {
          // Save antropometri data in secure storage
          await secureStorage.write(
            key: antropometriKey,
            value: data.toString(),
          );
          emit(BaseState.success(data: data));
        },
      );
    } catch (e) {
      emit(BaseState.error(message: e.toString()));
    }
  }

  void getDetailAntropometriData() async {
    emit(BaseState.loading());
    try {
      final response = await getAntropometriUseCase.call(NoParams());

      return response.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) async {
          // Save antropometri data in secure storage
          await secureStorage.write(
            key: antropometriKey,
            value: data.toString(),
          );
          if (data != null) {
            emit(BaseState.success(data: data));
          } else {
            emit(BaseState.error(message: "Data Not Found"));
          }
        },
      );
    } catch (e) {
      emit(BaseState.error(message: e.toString()));
    }
  }
}
