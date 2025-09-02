import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/obat_entity.dart';
import '../../repository/assesment_repo.dart';

class AddMedicineUseCase
    extends UseCase<List<ObatEntity>, AddParams<ObatEntity>> {
  final AssesmentRepository repository;

  const AddMedicineUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ObatEntity>>> call(
    AddParams<ObatEntity> params,
  ) async {
    return await repository.addMedicine(params);
  }
}
