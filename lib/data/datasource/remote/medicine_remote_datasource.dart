import '../../../core/api_service.dart';
import '../../../core/error.dart';
import '../../../domain/entity/assesment/obat_entity.dart';
import '../../model/assesment/obat/obat.dart';

abstract class MedicineRemoteDatasource {
  Future<List<Obat>> getAllMedicine(int userId, String date);
  Future<List<Obat>> addMedicine(int userId, ObatEntity medicine);
  Future<List<Obat>> updateStatusMedicine(
    int userId,
    int medicineId,
    int status,
    int count,
  );
}

class MedicineRemoteDatasourceImpl implements MedicineRemoteDatasource {
  final ApiService apiService;
  MedicineRemoteDatasourceImpl({required this.apiService});

  @override
  Future<List<Obat>> addMedicine(int userId, ObatEntity medicine) async {
    try {
      final response = await apiService.postData('/users/$userId/medicines', {
        'users_id': userId,
        'nama': medicine.name,
        'tanggal': medicine.date,
        'durasi': medicine.duration,
        'dosis': medicine.dosis,
        'type': medicine.type,
      });
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Obat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Obat>> getAllMedicine(int userId, String date) async {
    try {
      final response = await apiService.fetchData(
        '/users/$userId/medicines?date=$date',
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Obat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Obat>> updateStatusMedicine(
    int userId,
    int medicineId,
    int status,
    int count,
  ) async {
    try {
      final response = await apiService.patchData(
        '/users/$userId/medicines/$medicineId',
        {'status': status, 'count': count},
      );
      final responseData = response.data as Map<String, dynamic>;
      return (responseData['list'] as List)
          .map((e) => Obat.fromJson(e))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
