import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/obat_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListMedicineUseCase extends UseCase<List<ObatEntity>, SearchParams> {
  final AssesmentRepository repository;

  GetListMedicineUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ObatEntity>>> call(SearchParams params) async {
    return await repository.getAllMedicine(params);
  }
}
