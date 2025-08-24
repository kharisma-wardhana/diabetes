import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/kolesterol_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListKolesterolUsecase
    extends UseCase<List<KolesterolEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListKolesterolUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<KolesterolEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListKolesterol(params);
  }
}
