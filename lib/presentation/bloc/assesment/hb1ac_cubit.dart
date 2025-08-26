import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/hb1ac_entity.dart';
import '../../../domain/usecase/assesment/add_hb_usecase.dart';
import '../../../domain/usecase/assesment/get_list_hb_usecase.dart';

class Hb1acCubit extends Cubit<BaseState<List<Hb1acEntity>>> {
  final GetListHbUseCase getListHbUsecase;
  final AddHbUseCase addHbUsecase;

  Hb1acCubit({required this.getListHbUsecase, required this.addHbUsecase})
    : super(BaseState.initial());

  Future<void> getListHb(String date) async {
    emit(BaseState.loading());
    final result = await getListHbUsecase.call(SearchParams(date: date));

    return result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (data) => emit(BaseState.success(data: data)),
    );
  }

  Future<void> addHba1c(String date, double total) async {
    emit(BaseState.loading());
    final result = await addHbUsecase.call(
      AddParams(
        data: Hb1acEntity(date: date, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (data) => emit(BaseState.success(data: data)),
    );
  }
}
