import '../../../commons/injection/injection_adapter.dart';
import '../data/data_sources/authentication_remote_datasource.dart';
import '../data/repositories/authentication_repository.dart';
import '../domain/repositories/i_authentication_repository.dart';
import '../domain/use_cases/signin_usecase.dart';
import '../domain/use_cases/signup_usecase.dart';
import '../presentation/manager/authentication/authentication_cubit.dart';

class AuthenticationInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<IAuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSource(),
    );

    dependency.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository(
        remoteDataSource: dependency.get<IAuthenticationRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<SignInUsecase>(
      () =>
          SignInUsecase(repository: dependency.get<AuthenticationRepository>()),
    );

    dependency.registerFactory<SignUpUsecase>(
      () =>
          SignUpUsecase(repository: dependency.get<AuthenticationRepository>()),
    );

    dependency.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(
        signInUsecase: dependency.get<SignInUsecase>(),
        signUpUsecase: dependency.get<SignUpUsecase>(),
      ),
    );
  }
}
