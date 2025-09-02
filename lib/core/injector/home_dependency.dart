import 'package:diabetes/presentation/bloc/kalori/kalori_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';

import '../../domain/repository/assesment_repo.dart';
import '../../domain/usecase/assesment/add_activity_usecase.dart';
import '../../domain/usecase/health/authorization_usecase.dart';
import '../../domain/usecase/health/health_usecase.dart';
import '../../domain/usecase/nutrition/add_nutrition_usecase.dart';
import '../../domain/usecase/nutrition/get_list_nutrition_usecase.dart';
import '../../presentation/bloc/activity/activity_bloc.dart';
import 'service_locator.dart';

class HomeDependency {
  HomeDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    // Register data sources
  }

  void _registerRepository() {
    // Register repositories
  }

  void _registerUseCases() {
    sl.registerLazySingleton(() => AuthorizationUseCase(health: sl<Health>()));
    sl.registerLazySingleton(() => HealthUseCase(health: sl<Health>()));
    sl.registerLazySingleton(
      () => AddActivityUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton(
      () => GetListNutritionUseCase(repository: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddNutritionUseCase(repository: sl<AssesmentRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerFactory(
      () => ActivityBloc(
        authorizationUsecase: sl<AuthorizationUseCase>(),
        healthUsecase: sl<HealthUseCase>(),
        addActivityUsecase: sl<AddActivityUseCase>(),
        storage: sl<FlutterSecureStorage>(),
      ),
    );
    sl.registerLazySingleton(
      () => KaloriBloc(
        getListNutritionUseCase: sl<GetListNutritionUseCase>(),
        addNutritionUseCase: sl<AddNutritionUseCase>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }
}
