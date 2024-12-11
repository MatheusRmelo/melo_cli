import 'package:melo_cli/example/core/navigation/manager/navigation_cubit.dart';

import '../../core/managers/manager_injection_container.dart';
import '../../modules/users/injection_container/users_injection_container.dart';
import 'injection_adapter.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final ManagerInjectionContainer managerInjectionContainer =
      ManagerInjectionContainer();
  final UsersInjectionContainer usersInjectionContainer =
      UsersInjectionContainer();

  dependency.registerFactory<NavigationCubit>(
    () => NavigationCubit(),
  );

  managerInjectionContainer(dependency);
  usersInjectionContainer(dependency);
}
