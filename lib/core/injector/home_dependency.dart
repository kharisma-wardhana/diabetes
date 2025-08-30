import 'package:health/health.dart';

import '../../domain/usecase/health/authorization_usecase.dart';
import '../../domain/usecase/health/health_usecase.dart';
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
  }

  void _registerCubit() {
    sl.registerFactory(
      () => ActivityBloc(
        authorizationUsecase: sl<AuthorizationUseCase>(),
        healthUsecase: sl<HealthUseCase>(),
      ),
    );
  }
}
