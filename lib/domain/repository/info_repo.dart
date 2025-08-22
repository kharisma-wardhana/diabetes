import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entity/article/article_entity.dart';
import '../entity/doctor/doctor_entity.dart';
import '../entity/video/video_entity.dart';

abstract class InfoRepo {
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
  Future<Either<Failure, ArticleEntity>> getArticle(int id);
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, List<VideoEntity>>> getVideos();
}
