import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/kalori/kalori_entity.dart';
import '../../repository/assesment_repo.dart';

class AddNutritionUseCase
    extends UseCase<List<KaloriEntity>, AddParams<KaloriEntity>> {
  final AssesmentRepository repository;
  const AddNutritionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<KaloriEntity>>> call(
    AddParams<KaloriEntity> params,
  ) async {
    return await repository.addNutrition(params);
  }
}
