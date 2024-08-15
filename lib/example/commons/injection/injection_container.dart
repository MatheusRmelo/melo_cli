import 'package:melo_cli/example/module/users/injection_container/shopping_list_injection_container.dart';

import 'injection_adapter.dart';

final dependency = InjectionAdapter();

Future<void> init() async {
  final UsersInjectionContainer usersInjectionContainer =
      UsersInjectionContainer();
  usersInjectionContainer(dependency);
}
