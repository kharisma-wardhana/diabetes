import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/assesment/assesment_entity.dart';
import '../../../domain/usecase/assesment/get_assesment_usecase.dart';

class AssesmentCubit extends Cubit<BaseState<AssesmentEntity>> {
  final GetAssesmentUsecase getAssesmentUsecase;

  AssesmentCubit({required this.getAssesmentUsecase})
    : super(BaseState.initial());

  Future<void> getAssesment() async {
    emit(BaseState.loading());
    final result = await getAssesmentUsecase(NoParams());
    result.fold(
      (failure) => emit(BaseState.error(message: failure.message)),
      (assesment) => emit(BaseState.success(data: assesment)),
    );
  }
}
