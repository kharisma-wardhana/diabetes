import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/ginjal_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListGinjalUsecase extends UseCase<List<GinjalEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListGinjalUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<GinjalEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListGinjal(params);
  }
}
