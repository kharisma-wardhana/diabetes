import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/water_entity.dart';
import '../../../domain/usecase/assesment/add_water_usecase.dart';
import '../../../domain/usecase/assesment/get_list_water_usecase.dart';

class WaterCubit extends Cubit<BaseState<List<WaterEntity>>> {
  final GetListWaterUseCase getListWaterUseCase;
  final AddWaterUseCase addWaterUseCase;

  WaterCubit({required this.getListWaterUseCase, required this.addWaterUseCase})
    : super(const BaseState.initial());

  Future<void> getAllWater(String date) async {
    try {
      emit(const BaseState.loading());
      final result = await getListWaterUseCase.call(SearchParams(date: date));

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          if (data.isEmpty) {
            emit(const BaseState.empty('No water intake data found'));
          } else {
            emit(
              BaseState.success(
                data: data,
                message: 'Water intake data loaded successfully',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to load water data: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> addWater(String date, int target, int total) async {
    try {
      emit(const BaseState.loading('Adding water intake...'));
      final result = await addWaterUseCase.call(
        AddParams(
          data: WaterEntity(date: date, target: target, total: total),
        ),
      );

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          emit(
            BaseState.success(
              data: data,
              message: 'Water intake added successfully',
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to add water data: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
