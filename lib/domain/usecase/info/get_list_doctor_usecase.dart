import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/doctor/doctor_entity.dart';
import '../../repository/info_repo.dart';

class GetListDoctorUseCase extends UseCase<List<DoctorEntity>, NoParams> {
  final InfoRepo infoRepo;

  GetListDoctorUseCase({required this.infoRepo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParams params) async {
    return await infoRepo.getDoctors();
  }
}
