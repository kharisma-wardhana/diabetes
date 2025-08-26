import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/asam_urat_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListAsamUratUseCase
    extends UseCase<List<AsamUratEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListAsamUratUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<AsamUratEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListAsamUrat(params);
  }
}
