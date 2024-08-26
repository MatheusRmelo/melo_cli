import '../../../../commons/models/response.dart';

abstract class IAuthenticationRepository {
  Future<({Response response, bool result})> signIn(
      String email, String password);
  Future<({Response response, bool result})> signUp(
      String email, String password);
}
