import '../../modules/users/injection_container/users_injection_container.dart';
import 'injection_adapter.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final UsersInjectionContainer usersInjectionContainer =
      UsersInjectionContainer();
  usersInjectionContainer(dependency);
}
