import '../../../core/adapters/injection_adapter.dart';
import '../data/data_sources/users_remote_datasource.dart';
import '../data/repositories/users_repository.dart';
import '../domain/repositories/i_users_repository.dart';
import '../domain/use_cases/delete_user_usecase.dart';
import '../domain/use_cases/list_user_usecase.dart';
import '../presentation/manager/users/users_cubit.dart';

class UsersInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<IUsersRemoteDataSource>(
      () => UsersRemoteDataSource(),
    );

    dependency.registerFactory<IUsersRepository>(
      () => UsersRepository(
        remoteDataSource: dependency.get<IUsersRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<ListUserUsecase>(
      () => ListUserUsecase(repository: dependency.get<IUsersRepository>()),
    );

    dependency.registerFactory<DeleteUserUsecase>(
      () => DeleteUserUsecase(repository: dependency.get<IUsersRepository>()),
    );

    dependency.registerFactory<UsersCubit>(
      () => UsersCubit(
          deleteUserUsecase: dependency.get<DeleteUserUsecase>(),
          listUserUsecase: dependency.get<ListUserUsecase>()),
    );
  }
}
