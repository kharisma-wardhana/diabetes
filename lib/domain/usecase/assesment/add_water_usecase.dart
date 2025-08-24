import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/water_entity.dart';
import '../../repository/assesment_repo.dart';

class AddWaterUseCase
    extends UseCase<List<WaterEntity>, AddParams<WaterEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddWaterUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<WaterEntity>>> call(
    AddParams<WaterEntity> params,
  ) async {
    return await assesmentRepo.addWater(params);
  }
}
