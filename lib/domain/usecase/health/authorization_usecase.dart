import 'package:dartz/dartz.dart';
import 'package:health/health.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';

class AuthorizationUseCase implements UseCase<bool, List<HealthDataType>> {
  final Health health;

  const AuthorizationUseCase({required this.health});

  @override
  Future<Either<Failure, bool>> call(List<HealthDataType> types) async {
    // Request permissions for the specified health data types
    bool authorized = await health.requestAuthorization(types);
    if (!authorized) {
      // If authorization fails, return a failure
      return Left(
        UnauthorizedFailure(
          "Tidak dapat mengakses data kesehatan. Periksa izin aplikasi.",
        ),
      );
    }

    // Return whether the authorization was successful
    return Right(authorized);
  }
}
