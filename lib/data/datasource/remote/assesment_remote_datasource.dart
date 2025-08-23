import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../../domain/entity/assesment/antropometri/antropometri_entity.dart';
import '../../model/assesment/antropometri/antropometri.dart';

abstract class AssesmentRemoteDatasource {
  Future<Antropometri> addAntropometri(
    int userId,
    AntropometriEntity antropometri,
  );
  Future<Antropometri?> getDetailAntropometri(int userId);
}

class AssesmentRemoteDatasourceImpl implements AssesmentRemoteDatasource {
  final ApiService apiService;

  AssesmentRemoteDatasourceImpl({required this.apiService});

  @override
  Future<Antropometri> addAntropometri(
    int userId,
    AntropometriEntity antropometri,
  ) async {
    try {
      int statusInt = 0;
      if (antropometri.status == 'Obesitas') {
        statusInt = 2;
      }
      if (antropometri.status == 'Normal') {
        statusInt = 1;
      }
      final response = await apiService
          .postData('/users/$userId/anthropometrics', {
            'users_id': userId,
            'tinggi': antropometri.height,
            'berat': antropometri.weight,
            'hasil': antropometri.result,
            'lingkar_perut': antropometri.stomach,
            'lingkar_lengan': antropometri.hand,
            'jenis_aktivitas': antropometri.activity,
            'status': statusInt,
          });
      final responseData = response.data as Map<String, dynamic>;
      return Antropometri.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Antropometri?> getDetailAntropometri(int userId) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/anthropometrics',
      );
      if (response.data == null) {
        return null;
      }
      final responseData = response.data as Map<String, dynamic>;
      return Antropometri.fromJson(responseData);
    } on ServerException {
      rethrow;
    }
  }
}
