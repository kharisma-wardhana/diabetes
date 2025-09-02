import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasource/remote/user_remote_datasource.dart';
import '../../data/repository/user_repo_impl.dart';
import '../../domain/repository/user_repo.dart';
import '../../domain/usecase/auth/login_usecase.dart';
import '../../domain/usecase/auth/register_usecase.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import 'service_locator.dart';

class UserDependency {
  UserDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(apiService: sl()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<UserRepository>(
      () => UserRepoImpl(remoteDataSource: sl<UserRemoteDatasource>()),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(sl<UserRepository>()),
    );
    sl.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(sl<UserRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton(
      () => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        registerUsecase: sl<RegisterUsecase>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }
}
