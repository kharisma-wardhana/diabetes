import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant.dart';
import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entity/assesment/antropometri/antropometri_entity.dart';
import '../../domain/repository/assesment_repo.dart';
import '../datasource/remote/assesment_remote_datasource.dart';

class AssesmentRepositoryImpl extends AssesmentRepository {
  final AssesmentRemoteDatasource remoteDatasource;
  final FlutterSecureStorage secureStorage;

  AssesmentRepositoryImpl({
    required this.remoteDatasource,
    required this.secureStorage,
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
}
