import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../../domain/usecase/nutrition/add_nutrition_usecase.dart';
import '../../../domain/usecase/nutrition/get_list_nutrition_usecase.dart';

class KaloriCubit extends Cubit<BaseState> {
  final AddNutritionUseCase addNutritionUseCase;
  final GetListNutritionUseCase getListNutritionUseCase;

  KaloriCubit({
    required this.addNutritionUseCase,
    required this.getListNutritionUseCase,
  }) : super(const BaseState.initial());

  double calculateBMI(double height, double weight) {
    if (height <= 0 || weight <= 0) return 0;
    return weight / (height * 0.02);
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

  Future<void> getAllNutrition(String date) async {
    emit(BaseState.loading());
    final result = await getListNutritionUseCase.call(SearchParams(date: date));

    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        emit(BaseState.success(data: data));
      },
    );
  }

  Future<void> addNutrition(
    String date,
    String type,
    String name,
    int total,
  ) async {
    emit(BaseState.loading());
    final result = await addNutritionUseCase.call(
      AddParams(
        data: KaloriEntity(
          date: date,
          type: type,
          name: name,
          total: total.toString(),
        ),
      ),
    );
    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty('No data available'));
          return;
        }
        emit(BaseState.success(data: data));
      },
    );
  }
}
