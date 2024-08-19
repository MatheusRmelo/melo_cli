import '../../../commons/injection/injection_adapter.dart';
import '../data/data_sources/users_remote_datasource.dart';
import '../data/repositories/users_repository.dart';
import '../domain/repositories/i_users_repository.dart';
import '../domain/use_cases/create_user_usecase.dart';
import '../domain/use_cases/delete_user_usecase.dart';
import '../domain/use_cases/detail_user_usecase.dart';
import '../domain/use_cases/list_user_usecase.dart';
import '../domain/use_cases/update_user_usecase.dart';
import '../presentation/manager/users/users_cubit.dart';
import '../presentation/manager/users_form/users_form_cubit.dart';

class UsersInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<IUsersRemoteDataSource>(
      () => UsersRemoteDataSource(),
    );

    dependency.registerFactory<IUsersListRepository>(
      () => UsersRepository(
        remoteDataSource: dependency.get<IUsersRemoteDataSource>(),
      ),
    );

    dependency.registerFactory<ListUserUsecase>(
      () => ListUserUsecase(repository: dependency.get<IUsersListRepository>()),
    );

    dependency.registerFactory<DeleteUserUsecase>(
      () =>
          DeleteUserUsecase(repository: dependency.get<IUsersListRepository>()),
    );

    dependency.registerFactory<DetailUserUsecase>(
      () =>
          DetailUserUsecase(repository: dependency.get<IUsersListRepository>()),
    );

    dependency.registerFactory<UpdateUserUsecase>(
      () =>
          UpdateUserUsecase(repository: dependency.get<IUsersListRepository>()),
    );

    dependency.registerFactory<CreateUserUsecase>(
      () =>
          CreateUserUsecase(repository: dependency.get<IUsersListRepository>()),
    );

    dependency.registerFactory<UsersCubit>(
      () => UsersCubit(
          deleteUserUsecase: dependency.get<DeleteUserUsecase>(),
          listUserUsecase: dependency.get<ListUserUsecase>()),
    );

    dependency.registerFactory<UsersFormCubit>(
      () => UsersFormCubit(
        detailUserUsecase: dependency.get<DetailUserUsecase>(),
        updateUserUsecase: dependency.get<UpdateUserUsecase>(),
        createUserUsecase: dependency.get<CreateUserUsecase>(),
      ),
    );
  }
}
