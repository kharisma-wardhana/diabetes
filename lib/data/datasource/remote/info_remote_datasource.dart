import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../model/article/article.dart';
import '../../model/doctor/doctor.dart';
import '../../model/video/video.dart';

abstract class InfoRemoteDatasource {
  Future<List<Article>> getArticles();
  Future<Article> getArticle(int id);
  Future<List<Doctor>> getDoctors();
  Future<List<Video>> getVideos();
}

class InfoRemoteDatasourceImpl implements InfoRemoteDatasource {
  final ApiService apiService;

  InfoRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Article>> getArticles() async {
    try {
      final response = await apiService.fetchData('/articles');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Article> getArticle(int id) async {
    try {
      final response = await apiService.fetchData('/articles/$id');
      final responseData = response.data as Map<String, dynamic>;
      return Article.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Doctor>> getDoctors() async {
    try {
      final response = await apiService.fetchData('/doctors');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Doctor.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Video>> getVideos() async {
    try {
      final response = await apiService.fetchData('/videos');
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Video.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
