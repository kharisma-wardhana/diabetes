import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/gula_darah/gula_darah_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListBloodSugarUseCase
    extends UseCase<List<GulaDarahEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;

  const GetListBloodSugarUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListGulaDarah(params);
  }
}
