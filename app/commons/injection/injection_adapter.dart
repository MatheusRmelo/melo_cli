import 'package:get_it/get_it.dart';

class InjectionAdapter {
  final GetIt _getIt = GetIt.instance;

  void registerFactory<T extends Object>(T Function() instance) {
    _getIt.registerFactory<T>(instance);
  }

  void registerLazySingleton<T extends Object>(T Function() instance) {
    _getIt.registerLazySingleton<T>(instance);
  }

  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
