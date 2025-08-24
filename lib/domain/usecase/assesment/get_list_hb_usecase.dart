import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/hb1ac_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListHbUsecase extends UseCase<List<Hb1acEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListHbUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<Hb1acEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListHb1ac(params);
  }
}
