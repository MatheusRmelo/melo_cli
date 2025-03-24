import '../../../core/adapters/injection_adapter.dart';
import '../data/data_sources/api_splash_remote_datasource.dart';
import '../data/repositories/splash_repository.dart';
import '../domain/repositories/i_splash_repository.dart';
import '../domain/use_cases/check_is_logged_usecase.dart';
import '../presentation/manager/splash/splash_cubit.dart';

class SplashInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<ISplashRemoteDataSource>(
      () => SplashRemoteDataSource(),
    );

    dependency.registerFactory<ISplashRepository>(
      () => SplashRepository(
        remoteDataSource: dependency.get<ISplashRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<CheckIsLoggedUsecase>(
      () =>
          CheckIsLoggedUsecase(repository: dependency.get<ISplashRepository>()),
    );

    dependency.registerFactory<SplashCubit>(
      () => SplashCubit(
        checkIsLoggedUsecase: dependency.get<CheckIsLoggedUsecase>(),
      ),
    );
  }
}
