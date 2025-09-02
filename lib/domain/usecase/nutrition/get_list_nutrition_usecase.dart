import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/assesment/kalori/kalori_entity.dart';
import '../../repository/assesment_repo.dart';

class GetListNutritionUseCase
    extends UseCase<List<KaloriEntity>, SearchParams> {
  final AssesmentRepository repository;

  GetListNutritionUseCase({required this.repository});

  @override
  Future<Either<Failure, List<KaloriEntity>>> call(SearchParams params) async {
    return await repository.getAllNutrition(params);
  }
}
