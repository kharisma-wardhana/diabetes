import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasource/remote/assesment_remote_datasource.dart';
import '../../data/datasource/remote/medicine_remote_datasource.dart';
import '../../data/datasource/remote/nutrition_remote_datasource.dart';
import '../../data/repository/assesment_repo_impl.dart';
import '../../domain/repository/assesment_repo.dart';
import '../../domain/usecase/assesment/add_asam_urat_usecase.dart';
import '../../domain/usecase/assesment/add_blood_pressure_usecase.dart';
import '../../domain/usecase/assesment/add_blood_sugar_usecase.dart';
import '../../domain/usecase/assesment/add_ginjal_usecase.dart';
import '../../domain/usecase/assesment/add_hb_usecase.dart';
import '../../domain/usecase/assesment/add_kolesterol_usecase.dart';
import '../../domain/usecase/assesment/add_water_usecase.dart';
import '../../domain/usecase/assesment/antropometri/add_antropometri_usecase.dart';
import '../../domain/usecase/assesment/antropometri/get_antropometri_usecase.dart';
import '../../domain/usecase/assesment/get_assesment_usecase.dart';
import '../../domain/usecase/assesment/get_list_asam_urat_usecase.dart';
import '../../domain/usecase/assesment/get_list_blood_pressure_usecase.dart';
import '../../domain/usecase/assesment/get_list_blood_sugar_usecase.dart';
import '../../domain/usecase/assesment/get_list_ginjal_usecase.dart';
import '../../domain/usecase/assesment/get_list_hb_usecase.dart';
import '../../domain/usecase/assesment/get_list_kolesterol_usecase.dart';
import '../../domain/usecase/assesment/get_list_water_usecase.dart';
import '../../domain/usecase/medicine/add_medicine_usecase.dart';
import '../../domain/usecase/medicine/get_list_medicine_usecase.dart';
import '../../domain/usecase/medicine/update_status_medicine_usecase.dart';
import '../../presentation/bloc/assesment/antropometri_cubit.dart';
import '../../presentation/bloc/assesment/asam_urat_cubit.dart';
import '../../presentation/bloc/assesment/assesment_cubit.dart';
import '../../presentation/bloc/assesment/ginjal_cubit.dart';
import '../../presentation/bloc/assesment/gula_cubit.dart';
import '../../presentation/bloc/assesment/hb1ac_cubit.dart';
import '../../presentation/bloc/assesment/kolesterol_cubit.dart';
import '../../presentation/bloc/assesment/obat_cubit.dart';
import '../../presentation/bloc/assesment/tensi_cubit.dart';
import '../../presentation/bloc/assesment/water_cubit.dart';
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

    sl.registerLazySingleton<NutritionRemoteDatasource>(
      () => NutritionRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
    sl.registerLazySingleton<MedicineRemoteDatasource>(
      () => MedicineRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<AssesmentRepository>(
      () => AssesmentRepositoryImpl(
        secureStorage: sl<FlutterSecureStorage>(),
        remoteDatasource: sl<AssesmentRemoteDatasource>(),
        nutritionRemoteDataSource: sl<NutritionRemoteDatasource>(),
        medicineRemoteDataSource: sl<MedicineRemoteDatasource>(),
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
    sl.registerLazySingleton(
      () => GetAssesmentUseCase(assesmentRepository: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListHbUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddHbUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListKolesterolUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddKolesterolUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListBloodSugarUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddBloodSugarUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListWaterUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddWaterUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListGinjalUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddGinjalUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListAsamUratUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddAsamUratUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () =>
          GetListBloodPressureUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddBloodPressureUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => GetListMedicineUseCase(repository: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => AddMedicineUseCase(repository: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton(
      () => UpdateStatusMedicineUseCase(repository: sl<AssesmentRepository>()),
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
    sl.registerLazySingleton(
      () => AssesmentCubit(getAssesmentUsecase: sl<GetAssesmentUseCase>()),
    );
    sl.registerLazySingleton(
      () => GulaCubit(
        getListBloodSugarUseCase: sl<GetListBloodSugarUseCase>(),
        addBloodSugarUseCase: sl<AddBloodSugarUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => Hb1acCubit(
        addHbUsecase: sl<AddHbUseCase>(),
        getListHbUsecase: sl<GetListHbUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => KolesterolCubit(
        addKolesterolUsecase: sl<AddKolesterolUseCase>(),
        getListKolesterolUsecase: sl<GetListKolesterolUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => WaterCubit(
        addWaterUseCase: sl<AddWaterUseCase>(),
        getListWaterUseCase: sl<GetListWaterUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => GinjalCubit(
        addGinjalUsecase: sl<AddGinjalUseCase>(),
        getListGinjalUsecase: sl<GetListGinjalUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => AsamUratCubit(
        getListAsamUratUsecase: sl<GetListAsamUratUseCase>(),
        addAsamUratUsecase: sl<AddAsamUratUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => TensiCubit(
        getListTekananDarahUseCase: sl<GetListBloodPressureUseCase>(),
        addBloodPressureUseCase: sl<AddBloodPressureUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => ObatCubit(
        addMedicineUseCase: sl<AddMedicineUseCase>(),
        getListMedicineUseCase: sl<GetListMedicineUseCase>(),
        updateStatusMedicineUseCase: sl<UpdateStatusMedicineUseCase>(),
      ),
    );
  }
}
