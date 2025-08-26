import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/ginjal_entity.dart';
import '../../../domain/usecase/assesment/add_ginjal_usecase.dart';
import '../../../domain/usecase/assesment/get_list_ginjal_usecase.dart';

class GinjalCubit extends Cubit<BaseState<List<GinjalEntity>>> {
  final GetListGinjalUseCase getListGinjalUsecase;
  final AddGinjalUseCase addGinjalUsecase;

  GinjalCubit({
    required this.getListGinjalUsecase,
    required this.addGinjalUsecase,
  }) : super(BaseState.initial());

  Future<void> getListGinjal(String date) async {
    emit(BaseState.loading());
    final result = await getListGinjalUsecase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (data) {
        if (data.isEmpty) {
          emit(BaseState.empty());
        } else {
          emit(BaseState.success(data: data));
        }
      },
    );
  }

  Future<void> addGinjal(String date, int type, double total) async {
    emit(BaseState.loading());
    final result = await addGinjalUsecase.call(
      AddParams(
        data: GinjalEntity(date: date, type: type, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (data) => emit(BaseState.success(data: data)),
    );
  }
}
