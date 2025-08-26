import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/asam_urat_entity.dart';
import '../../../domain/usecase/assesment/add_asam_urat_usecase.dart';
import '../../../domain/usecase/assesment/get_list_asam_urat_usecase.dart';

class AsamUratCubit extends Cubit<BaseState<List<AsamUratEntity>>> {
  final GetListAsamUratUseCase getListAsamUratUsecase;
  final AddAsamUratUseCase addAsamUratUsecase;

  AsamUratCubit({
    required this.getListAsamUratUsecase,
    required this.addAsamUratUsecase,
  }) : super(const BaseState.initial());

  Future<void> getListAsamUrat(String date) async {
    try {
      emit(const BaseState.loading());
      final result = await getListAsamUratUsecase.call(
        SearchParams(date: date),
      );

      result.fold(
        (failure) =>
            emit(BaseState.error(message: failure.message, error: failure)),
        (data) {
          if (data.isEmpty) {
            emit(const BaseState.empty('No uric acid data found'));
          } else {
            emit(
              BaseState.success(
                data: data,
                message: 'Uric acid data loaded successfully',
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      emit(
        BaseState.error(
          message: 'Failed to load uric acid data: ${e.toString()}',
          error: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<void> addAsamUrat(String date, double total) async {
    emit(BaseState.loading());
    final result = await addAsamUratUsecase.call(
      AddParams(
        data: AsamUratEntity(date: date, total: total),
      ),
    );

    return result.fold(
      (failure) =>
          emit(BaseState.error(message: failure.message, error: failure)),
      (data) {
        emit(BaseState.success(data: data));
      },
    );
  }
}
