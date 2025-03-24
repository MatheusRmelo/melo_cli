import '../../../../commons/models/response.dart';

abstract class ISplashRepository {
  Future<({Response response, bool result})> checkIsLogged();
}
