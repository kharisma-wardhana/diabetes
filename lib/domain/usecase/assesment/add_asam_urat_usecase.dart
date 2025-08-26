import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/asam_urat_entity.dart';
import '../../repository/assesment_repo.dart';

class AddAsamUratUseCase
    extends UseCase<List<AsamUratEntity>, AddParams<AsamUratEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddAsamUratUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<AsamUratEntity>>> call(
    AddParams<AsamUratEntity> params,
  ) async {
    return await assesmentRepo.addAsamUrat(params);
  }
}
