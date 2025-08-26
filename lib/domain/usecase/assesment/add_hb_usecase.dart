import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/hb1ac_entity.dart';
import '../../repository/assesment_repo.dart';

class AddHbUseCase extends UseCase<List<Hb1acEntity>, AddParams<Hb1acEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddHbUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<Hb1acEntity>>> call(
    AddParams<Hb1acEntity> params,
  ) async {
    return await assesmentRepo.addHb1ac(params);
  }
}
