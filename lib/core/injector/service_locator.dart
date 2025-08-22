import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health/health.dart';
import 'package:get_it/get_it.dart';

import '../api_service.dart';
import '../app_navigator.dart';
import '../constant.dart';
import '../dio_client.dart';
import 'assesment_dependency.dart';
import 'home_dependency.dart';
import 'info_dependency.dart';
import 'onboarding_dependency.dart';
import 'user_dependency.dart';

final sl = GetIt.instance;

class Injector {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerHealth();
    _registerDomains();
  }

  void _registerHealth() {
    sl.registerLazySingleton<Health>(() => Health());
  }

  Future<void> _registerSharedDependencies() async {
    await const SharedLibDependencies().registerCore();
  }

  void _registerDomains() {
    UserDependency();
    OnboardingDependency();
    HomeDependency();
    AssesmentDependency();
    InfoDependency();
  }
}

class SharedLibDependencies {
  const SharedLibDependencies();

  Future<void> registerCore() async {
    sl.registerLazySingleton<AppNavigator>(() => AppNavigatorImpl());
    sl.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: baseURL, secureStorage: sl()),
    );
    sl.registerLazySingleton<ApiService>(
      () => ApiService(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    );
  }
}
