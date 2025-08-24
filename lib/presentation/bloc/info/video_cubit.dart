import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/entity/video/video_entity.dart';
import '../../../domain/usecase/info/get_list_video_usecase.dart';

class VideoCubit extends Cubit<BaseState<List<VideoEntity>>> {
  final GetListVideoUseCase getListVideoUseCase;

  VideoCubit({required this.getListVideoUseCase}) : super(BaseState.initial());

  Future<void> getAllVideo() async {
    emit(BaseState.loading());
    try {
      final result = await getListVideoUseCase.call(NoParams());

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
