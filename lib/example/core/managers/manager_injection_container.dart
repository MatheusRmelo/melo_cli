import '../../commons/injection/injection_adapter.dart';
import 'user_manager.dart';

class ManagerInjectionContainer {
  void call(InjectionAdapter dependency) {
    dependency.registerFactory<UserManager>(
      () => UserManager(),
    );
  }
}
