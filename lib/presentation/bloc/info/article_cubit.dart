import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_state.dart';
import '../../../core/usecase.dart';
import '../../../domain/usecase/info/get_detail_article_usecase.dart';
import '../../../domain/usecase/info/get_list_article_usecase.dart';

class ArticleCubit extends Cubit<BaseState<dynamic>> {
  final GetListArticleUseCase getListArticleUseCase;
  final GetDetailArticleUseCase getDetailArticleUseCase;

  ArticleCubit({
    required this.getListArticleUseCase,
    required this.getDetailArticleUseCase,
  }) : super(BaseState.initial());

  Future<void> getAllArticle() async {
    emit(BaseState.loading());
    try {
      final result = await getListArticleUseCase.call(NoParams());

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

  Future<void> getArticleDetail(int articleId) async {
    emit(BaseState.loading());
    try {
      final result = await getDetailArticleUseCase.call(articleId);

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
