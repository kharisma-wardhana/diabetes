import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/water_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListWaterUseCase extends UseCase<List<WaterEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListWaterUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<WaterEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListWater(params);
  }
}
