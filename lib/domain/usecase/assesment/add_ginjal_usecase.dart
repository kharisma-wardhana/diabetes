import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/ginjal_entity.dart';
import '../../repository/assesment_repo.dart';

class AddGinjalUsecase
    extends UseCase<List<GinjalEntity>, AddParams<GinjalEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddGinjalUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<GinjalEntity>>> call(
    AddParams<GinjalEntity> params,
  ) async {
    return await assesmentRepo.addGinjal(params);
  }
}
