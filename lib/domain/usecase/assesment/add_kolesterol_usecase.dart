import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/kolesterol_entity.dart';
import '../../repository/assesment_repo.dart';

class AddKolesterolUsecase
    extends UseCase<List<KolesterolEntity>, AddParams<KolesterolEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddKolesterolUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<KolesterolEntity>>> call(
    AddParams<KolesterolEntity> params,
  ) async {
    return await assesmentRepo.addKolesterol(params);
  }
}
