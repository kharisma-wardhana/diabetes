import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../entity/assesment/antropometri/antropometri_entity.dart';

abstract class AssesmentRepository {
  Future<Either<Failure, AntropometriEntity>> addAntropometri(
    AddParams<AntropometriEntity> params,
  );

  Future<Either<Failure, AntropometriEntity?>> getDetailAntropometri();
}
