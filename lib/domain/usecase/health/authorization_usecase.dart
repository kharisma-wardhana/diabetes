import 'package:dartz/dartz.dart';
import 'package:health/health.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';

class AuthorizationUseCase implements UseCase<bool, HealthParams> {
  final Health health;

  const AuthorizationUseCase({required this.health});

  @override
  Future<Either<Failure, bool>> call(HealthParams params) async {
    // Request permissions for the specified health data types
    bool authorized = await health.requestAuthorization(
      params.types,
      permissions: params.permissions,
    );
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

class HealthParams {
  final List<HealthDataType> types;
  final List<HealthDataAccess> permissions;

  HealthParams({
    required this.types,
    this.permissions = const [HealthDataAccess.READ],
  });
}
