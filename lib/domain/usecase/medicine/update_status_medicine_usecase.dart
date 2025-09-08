import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/obat_entity.dart';
import '../../repository/assesment_repo.dart';

class UpdateStatusMedicineUseCase
    extends UseCase<List<ObatEntity>, UpdateParams<Map<String, int>>> {
  final AssesmentRepository repository;

  const UpdateStatusMedicineUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ObatEntity>>> call(
    UpdateParams<Map<String, int>> params,
  ) async {
    return await repository.updateStatusMedicine(params);
  }
}
