import 'package:dartz/dartz.dart';

import '../../../../core/error.dart';
import '../../../../core/usecase.dart';
import '../../../entity/assesment/antropometri/antropometri_entity.dart';
import '../../../repository/assesment_repo.dart';

class GetAntropometriUseCase extends UseCase<AntropometriEntity?, NoParams> {
  final AssesmentRepository assesmentRepo;

  const GetAntropometriUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, AntropometriEntity?>> call(NoParams params) async {
    return await assesmentRepo.getDetailAntropometri();
  }
}
