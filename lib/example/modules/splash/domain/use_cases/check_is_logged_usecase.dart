import '../../../../commons/models/response.dart';
import '../repositories/i_splash_repository.dart';

class CheckIsLoggedUsecase {
  final ISplashRepository repository;
  CheckIsLoggedUsecase({required this.repository});

  Future<({Response? response, bool? result})> call() async =>
      repository.checkIsLogged();
}
