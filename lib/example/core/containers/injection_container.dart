import '../../core/navigation/manager/navigation_cubit.dart';
import '../../modules/users/injection_container/users_injection_container.dart';
import '../adapters/injection_adapter.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final UsersInjectionContainer usersInjectionContainer =
      UsersInjectionContainer();

  dependency.registerLazySingleton<NavigationCubit>(
    () => NavigationCubit(),
  );

  usersInjectionContainer(dependency);
}
