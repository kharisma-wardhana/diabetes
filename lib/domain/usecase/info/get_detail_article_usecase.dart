import 'package:dartz/dartz.dart';
import 'package:diabetes/core/usecase.dart';

import '../../../core/error.dart';
import '../../entity/article/article_entity.dart';
import '../../repository/info_repo.dart';

class GetDetailArticleUseCase extends UseCase<ArticleEntity, int> {
  final InfoRepo infoRepo;

  GetDetailArticleUseCase({required this.infoRepo});

  @override
  Future<Either<Failure, ArticleEntity>> call(int params) async {
    return await infoRepo.getArticle(params);
  }
}
