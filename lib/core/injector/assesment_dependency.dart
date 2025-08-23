import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasource/remote/assesment_remote_datasource.dart';
import '../../data/repository/assesment_repo_impl.dart';
import '../../domain/repository/assesment_repo.dart';
import '../../domain/usecase/assesment/antropometri/add_antropometri_usecase.dart';
import '../../domain/usecase/assesment/antropometri/get_antropometri_usecase.dart';
import '../../presentation/bloc/assesment/antropometri_cubit.dart';
import '../api_service.dart';
import 'service_locator.dart';

class AssesmentDependency {
  AssesmentDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AssesmentRemoteDatasource>(
      () => AssesmentRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<AssesmentRepository>(
      () => AssesmentRepositoryImpl(
        remoteDatasource: sl<AssesmentRemoteDatasource>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton(
      () => GetAntropometriUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddAntropometriUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton(
      () => AntropometriCubit(
        addAntropometriUseCase: sl<AddAntropometriUseCase>(),
        getAntropometriUseCase: sl<GetAntropometriUseCase>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }
}
