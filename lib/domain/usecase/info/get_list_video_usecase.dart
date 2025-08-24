import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entity/video/video_entity.dart';
import '../../repository/info_repo.dart';

class GetListVideoUseCase extends UseCase<List<VideoEntity>, NoParams> {
  final InfoRepo infoRepo;

  GetListVideoUseCase({required this.infoRepo});

  @override
  Future<Either<Failure, List<VideoEntity>>> call(NoParams params) async {
    return await infoRepo.getVideos();
  }
}
