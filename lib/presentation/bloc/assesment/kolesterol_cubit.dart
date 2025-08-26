import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/kolesterol_entity.dart';
import '../../../domain/usecase/assesment/add_kolesterol_usecase.dart';
import '../../../domain/usecase/assesment/get_list_kolesterol_usecase.dart';

class KolesterolCubit extends Cubit<BaseState<List<KolesterolEntity>>> {
  final GetListKolesterolUseCase getListKolesterolUsecase;
  final AddKolesterolUseCase addKolesterolUsecase;

  KolesterolCubit({
    required this.getListKolesterolUsecase,
    required this.addKolesterolUsecase,
  }) : super(BaseState.initial());

  Future<void> getListKolesterol(String date) async {
    emit(BaseState.loading());
    final result = await getListKolesterolUsecase.call(
      SearchParams(date: date),
    );

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

  Future<void> addKolesterol(String date, String type, int total) async {
    emit(BaseState.loading());
    String typeInt = '0';
    if (type == 'HDL') {
      typeInt = '1';
    } else if (type == 'Trigliserida') {
      typeInt = '2';
    } else if (type == 'Total') {
      typeInt = '3';
    }
    final result = await addKolesterolUsecase.call(
      AddParams(
        data: KolesterolEntity(date: date, type: typeInt, total: total),
      ),
    );

    return result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (data) => emit(BaseState.success(data: data)),
    );
  }
}
