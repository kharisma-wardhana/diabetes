import '../../data/datasource/remote/info_remote_datasource.dart';
import '../../data/repository/info_repo_impl.dart';
import '../../domain/repository/info_repo.dart';
import '../../domain/usecase/info/get_detail_article_usecase.dart';
import '../../domain/usecase/info/get_list_article_usecase.dart';
import '../../domain/usecase/info/get_list_doctor_usecase.dart';
import '../../domain/usecase/info/get_list_video_usecase.dart';
import '../../presentation/bloc/info/article_cubit.dart';
import '../../presentation/bloc/info/doctor_cubit.dart';
import '../../presentation/bloc/info/video_cubit.dart';
import '../api_service.dart';
import 'service_locator.dart';

class InfoDependency {
  InfoDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<InfoRemoteDatasource>(
      () => InfoRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<InfoRepo>(
      () => InfoRepoImpl(infoRemoteDatasource: sl<InfoRemoteDatasource>()),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton(
      () => GetListArticleUseCase(infoRepo: sl<InfoRepo>()),
    );
    sl.registerLazySingleton(
      () => GetDetailArticleUseCase(infoRepo: sl<InfoRepo>()),
    );
    sl.registerLazySingleton(
      () => GetListDoctorUseCase(infoRepo: sl<InfoRepo>()),
    );
    sl.registerLazySingleton(
      () => GetListVideoUseCase(infoRepo: sl<InfoRepo>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton(
      () => ArticleCubit(
        getListArticleUseCase: sl<GetListArticleUseCase>(),
        getDetailArticleUseCase: sl<GetDetailArticleUseCase>(),
      ),
    );
    sl.registerLazySingleton(
      () => DoctorCubit(getListDoctorUseCase: sl<GetListDoctorUseCase>()),
    );
    sl.registerLazySingleton(
      () => VideoCubit(getListVideoUseCase: sl<GetListVideoUseCase>()),
    );
  }
}
