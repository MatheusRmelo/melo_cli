import '../../core/managers/manager_injection_container.dart';
import '../../core/navigation/manager/navigation_cubit.dart';
import '../../modules/users/injection_container/users_injection_container.dart';
import '../adapters/injection_adapter.dart';
import '../managers/user_manager.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final ManagerInjectionContainer managerInjectionContainer =
      ManagerInjectionContainer();
  final UsersInjectionContainer usersInjectionContainer =
      UsersInjectionContainer();

  dependency.registerLazySingleton<NavigationCubit>(
    () => NavigationCubit(),
  );
  dependency.registerLazySingleton<UserManager>(
    () => UserManager(),
  );

  managerInjectionContainer(dependency);
  usersInjectionContainer(dependency);
}
