import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../../domain/usecase/assesment/add_blood_sugar_usecase.dart';
import '../../../domain/usecase/assesment/get_list_blood_sugar_usecase.dart';

class GulaCubit extends Cubit<BaseState<List<GulaDarahEntity>>> {
  final GetListBloodSugarUseCase getListBloodSugarUseCase;
  final AddBloodSugarUseCase addBloodSugarUseCase;

  GulaCubit({
    required this.getListBloodSugarUseCase,
    required this.addBloodSugarUseCase,
  }) : super(const BaseState.initial());

  Future<void> getListGula(String date) async {
    try {
      emit(const BaseState.loading());
      final result = await getListBloodSugarUseCase.call(
        SearchParams(date: date),
      );

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          if (data.isEmpty) {
            emit(const BaseState.empty('No blood sugar data found'));
          } else {
            emit(
              BaseState.success(
                data: data,
                message: 'Blood sugar data loaded successfully',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Unexpected error occurred: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> addGula(
    String date,
    String time,
    String type,
    String total,
  ) async {
    try {
      emit(const BaseState.loading('Adding blood sugar data...'));
      final result = await addBloodSugarUseCase.call(
        AddParams(
          data: GulaDarahEntity(
            date: date,
            time: time,
            type: int.parse(type),
            total: total,
          ),
        ),
      );

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          emit(
            BaseState.success(
              data: data,
              message: 'Blood sugar data added successfully',
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to add blood sugar data: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
