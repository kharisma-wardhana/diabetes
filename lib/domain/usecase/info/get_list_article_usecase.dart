import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/article/article_entity.dart';
import '../../repository/info_repo.dart';

class GetListArticleUseCase extends UseCase<List<ArticleEntity>, NoParams> {
  final InfoRepo infoRepo;

  GetListArticleUseCase({required this.infoRepo});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await infoRepo.getArticles();
  }
}
