import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../domain/entity/article/article_entity.dart';
import '../../domain/entity/doctor/doctor_entity.dart';
import '../../domain/entity/video/video_entity.dart';
import '../../domain/repository/info_repo.dart';
import '../datasource/remote/info_remote_datasource.dart';

class InfoRepoImpl extends InfoRepo {
  final InfoRemoteDatasource infoRemoteDatasource;

  InfoRepoImpl({required this.infoRemoteDatasource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() async {
    try {
      final articles = await infoRemoteDatasource.getArticles();
      return Right(articles.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArticleEntity>> getArticle(int id) async {
    try {
      final article = await infoRemoteDatasource.getArticle(id);
      return Right(article.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctors() async {
    try {
      final doctors = await infoRemoteDatasource.getDoctors();
      return Right(doctors.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() async {
    try {
      final videos = await infoRemoteDatasource.getVideos();
      return Right(videos.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
