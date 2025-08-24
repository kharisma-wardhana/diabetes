import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/doctor/doctor_entity.dart';
import '../../../domain/usecase/info/get_list_doctor_usecase.dart';

class DoctorCubit extends Cubit<BaseState<List<DoctorEntity>>> {
  final GetListDoctorUseCase getListDoctorUseCase;

  DoctorCubit({required this.getListDoctorUseCase})
    : super(BaseState.initial());

  Future<void> getAllDoctor() async {
    emit(BaseState.loading());
    try {
      final result = await getListDoctorUseCase.call(NoParams());

      return result.fold(
        (failure) => emit(BaseState.error(message: failure.message)),
        (data) {
          emit(BaseState.success(data: data));
        },
      );
    } catch (e) {
      emit(BaseState.error(message: e.toString()));
    }
  }
}
