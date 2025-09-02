import 'package:dartz/dartz.dart';
import 'package:diabetes/core/base_state.dart';
import 'package:health/health.dart';

import '../../../core/error.dart';
import '../../../core/injector/service_locator.dart';
import '../../../core/usecase.dart';
import '../../../presentation/bloc/assesment/antropometri_cubit.dart';
import '../../entity/health/health_entity.dart';

class HealthUseCase implements UseCase<HealthEntity, List<HealthDataType>> {
  final Health health;

  const HealthUseCase({required this.health});

  @override
  Future<Either<Failure, HealthEntity>> call(
    List<HealthDataType> params,
  ) async {
    final now = DateTime.now();
    final lastMonth = now.subtract(Duration(days: 30));

    List<HealthDataPoint> data = await health.getHealthDataFromTypes(
      types: params,
      startTime: lastMonth,
      endTime: now,
    );

    num steps = 0;
    num? heartRate;
    num? systolic;
    num? diastolic;

    for (var point in data) {
      switch (point.type) {
        case HealthDataType.STEPS:
          steps += point.value.toJson()['numericValue'] ?? 0;
          break;
        case HealthDataType.HEART_RATE:
          heartRate ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
          systolic ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
          diastolic ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        default:
          break;
      }
    }
    final weight = sl<AntropometriCubit>().state.data?.weight;
    return Right(
      HealthEntity(
        steps: steps.toInt(),
        heartRate: heartRate?.toInt() ?? 0,
        bloodPressure: systolic != null && diastolic != null
            ? "$systolic/$diastolic"
            : "-",
        kaloriBurned: steps.toInt() * ((weight ?? 0) * 0.0005),
      ),
    );
  }
}
