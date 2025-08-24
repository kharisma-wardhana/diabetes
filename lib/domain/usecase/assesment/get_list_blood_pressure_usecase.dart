import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/tensi_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListBloodPressureUseCase
    extends UseCase<List<TensiEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListBloodPressureUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<TensiEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListTekananDarah(params);
  }
}
