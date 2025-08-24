import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../repository/assesment_repo.dart';

class AddBloodSugarUseCase
    extends UseCase<List<GulaDarahEntity>, AddParams<GulaDarahEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddBloodSugarUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> call(
    AddParams<GulaDarahEntity> params,
  ) async {
    return await assesmentRepo.addGulaDarah(params);
  }
}
