import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../model/assesment/kalori/kalori.dart';

abstract class NutritionRemoteDatasource {
  Future<List<Kalori>> getAllNutrition(int userId, String date);
  Future<List<Kalori>> addNutrition(int userId, KaloriEntity params);
}

class NutritionRemoteDatasourceImpl implements NutritionRemoteDatasource {
  final ApiService apiService;
  NutritionRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Kalori>> getAllNutrition(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/nutritions?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Kalori.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Kalori>> addNutrition(int userId, KaloriEntity params) async {
    try {
      int type = 0;
      if (params.type == 'Siang') {
        type = 1;
      }
      if (params.type == 'Malam') {
        type = 2;
      }
      final response = await apiService.postData('/users/$userId/nutritions', {
        'users_id': userId,
        'nama': params.name,
        'tanggal': params.date,
        'type': type,
        'jumlah_kalori': params.total,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Kalori.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
