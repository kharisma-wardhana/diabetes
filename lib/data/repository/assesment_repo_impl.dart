import 'package:dartz/dartz.dart';
import 'package:diabetes/domain/entity/assesment/obat_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant.dart';
import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entity/assesment/activity/activity_entity.dart';
import '../../domain/entity/assesment/antropometri/antropometri_entity.dart';
import '../../domain/entity/assesment/asam_urat_entity.dart';
import '../../domain/entity/assesment/assesment_entity.dart';
import '../../domain/entity/assesment/ginjal_entity.dart';
import '../../domain/entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../domain/entity/assesment/hb1ac_entity.dart';
import '../../domain/entity/assesment/kalori/kalori_entity.dart';
import '../../domain/entity/assesment/kolesterol_entity.dart';
import '../../domain/entity/assesment/tensi_entity.dart';
import '../../domain/entity/assesment/water_entity.dart';
import '../../domain/repository/assesment_repo.dart';
import '../datasource/remote/assesment_remote_datasource.dart';
import '../datasource/remote/medicine_remote_datasource.dart';
import '../datasource/remote/nutrition_remote_datasource.dart';

class AssesmentRepositoryImpl extends AssesmentRepository {
  final FlutterSecureStorage secureStorage;
  final AssesmentRemoteDatasource remoteDatasource;
  final NutritionRemoteDatasource nutritionRemoteDataSource;
  final MedicineRemoteDatasource medicineRemoteDataSource;

  AssesmentRepositoryImpl({
    required this.remoteDatasource,
    required this.secureStorage,
    required this.nutritionRemoteDataSource,
    required this.medicineRemoteDataSource,
  });

  Future<int> getUserID() async {
    final userID = await secureStorage.read(key: userIDKey);
    if (userID == null) {
      throw InvalidInputFailure("userID null");
    }

    return int.parse(userID);
  }

  @override
  Future<Either<Failure, AntropometriEntity>> addAntropometri(
    AddParams<AntropometriEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final result = await remoteDatasource.addAntropometri(
        userID,
        params.data,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AntropometriEntity?>> getDetailAntropometri() async {
    try {
      final userID = await getUserID();
      final result = await remoteDatasource.getDetailAntropometri(userID);
      return Right(result?.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssesmentEntity>> getAssesment() async {
    try {
      final userID = await getUserID();
      final assesment = await remoteDatasource.getAssesment(userID);
      return Right(assesment.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> getListWater(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final waters = await remoteDatasource.getListWater(userID, params.date);
      return Right(waters.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> addWater(
    AddParams<WaterEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final waters = await remoteDatasource.addWater(userID, params.data);
      return Right(waters.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> addActivity(
    AddParams<ActivityEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.addActivity(userID, params.data);
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> getListActivity(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final activities = await remoteDatasource.getListActivity(
        userID,
        params.date,
      );
      return Right(activities.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> addAsamUrat(
    AddParams<AsamUratEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final asamUrat = await remoteDatasource.addAsamUrat(userID, params.data);
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> addGinjal(
    AddParams<GinjalEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final ginjal = await remoteDatasource.addGinjal(userID, params.data);
      return Right(ginjal.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> addGulaDarah(
    AddParams<GulaDarahEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final gula = await remoteDatasource.addGulaDarah(userID, params.data);
      return Right(gula.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> addHb1ac(
    AddParams<Hb1acEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final hb1ac = await remoteDatasource.addHb1ac(userID, params.data);
      return Right(hb1ac.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> addKolesterol(
    AddParams<KolesterolEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final kolesterol = await remoteDatasource.addKolesterol(
        userID,
        params.data,
      );
      return Right(kolesterol.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> addTekananDarah(
    AddParams<TensiEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final tensi = await remoteDatasource.addTekananDarah(userID, params.data);
      return Right(tensi.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> getListAsamUrat(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final asamUrat = await remoteDatasource.getListAsamUrat(
        userID,
        params.date,
      );
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> getListGinjal(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final ginjal = await remoteDatasource.getListGinjal(userID, params.date);
      return Right(ginjal.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> getListGulaDarah(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final gula = await remoteDatasource.getListGulaDarah(userID, params.date);
      return Right(gula.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> getListHb1ac(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final hb1ac = await remoteDatasource.getListHb1ac(userID, params.date);
      return Right(hb1ac.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> getListKolesterol(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final kolesterol = await remoteDatasource.getListKolesterol(
        userID,
        params.date,
      );
      return Right(kolesterol.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> getListTekananDarah(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final tensi = await remoteDatasource.getListTekananDarah(
        userID,
        params.date,
      );
      return Right(tensi.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AsamUratEntity>>> getGraphicAsamUrat(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final asamUrat = await remoteDatasource.getGraphicAsamUrat(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(asamUrat.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GinjalEntity>>> getGraphicGinjal(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicGinjal(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> getGraphicGula(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicGulaDarah(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Hb1acEntity>>> getGraphicHb1ac(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicHb1ac(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KolesterolEntity>>> getGraphicKolesterol(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicKolesterol(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TensiEntity>>> getGraphicTekananDarah(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicTekananDarah(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaterEntity>>> getGraphicWater(
    SearchParams params,
  ) async {
    final datetime = DateTime.parse(params.date);
    try {
      final userID = await getUserID();
      final data = await remoteDatasource.getGraphicWater(
        userID,
        '${datetime.month}',
        '${datetime.year}',
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KaloriEntity>>> getAllNutrition(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await nutritionRemoteDataSource.getAllNutrition(
        userID,
        params.date,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KaloriEntity>>> addNutrition(
    AddParams<KaloriEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await nutritionRemoteDataSource.addNutrition(
        userID,
        params.data,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ObatEntity>>> addMedicine(
    AddParams<ObatEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await medicineRemoteDataSource.addMedicine(
        userID,
        params.data,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ObatEntity>>> getAllMedicine(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await medicineRemoteDataSource.getAllMedicine(
        userID,
        params.date,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ObatEntity>>> updateStatusMedicine(
    UpdateParams<Map<String, int>> params,
  ) async {
    try {
      final userID = await getUserID();
      final data = await medicineRemoteDataSource.updateStatusMedicine(
        userID,
        params.dataId,
        params.data['status'] ?? 0,
        params.data['count'] ?? 0,
      );
      return Right(data.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
