import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/tensi_entity.dart';
import '../../../domain/usecase/assesment/add_blood_pressure_usecase.dart';
import '../../../domain/usecase/assesment/get_list_blood_pressure_usecase.dart';

class TensiCubit extends Cubit<BaseState<List<TensiEntity>>> {
  final GetListBloodPressureUseCase getListTekananDarahUseCase;
  final AddBloodPressureUseCase addBloodPressureUseCase;

  TensiCubit({
    required this.getListTekananDarahUseCase,
    required this.addBloodPressureUseCase,
  }) : super(const BaseState.initial());

  Future<void> getListTensi(String date) async {
    try {
      emit(const BaseState.loading());
      final result = await getListTekananDarahUseCase.call(
        SearchParams(date: date),
      );

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          if (data.isEmpty) {
            emit(const BaseState.empty('No blood pressure data found'));
          } else {
            emit(
              BaseState.success(
                data: data,
                message: 'Blood pressure data loaded successfully',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to load blood pressure data: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> addTensi(
    String date,
    String time,
    int sistole,
    int diastole,
  ) async {
    try {
      emit(const BaseState.loading('Adding blood pressure...'));
      final result = await addBloodPressureUseCase.call(
        AddParams(
          data: TensiEntity(
            date: date,
            time: time,
            sistole: sistole,
            diastole: diastole,
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
              message: 'Blood pressure added successfully',
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to add blood pressure: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
