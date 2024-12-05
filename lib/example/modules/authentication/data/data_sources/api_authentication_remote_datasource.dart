import '../../../../core/network/remote/api_client.dart';
import '../../../../commons/models/response_model.dart';

abstract class IAuthenticationRemoteDataSource {
  Future<ResponseModel<bool>> signIn(String email, String password);
  Future<ResponseModel<bool>> signUp(String email, String password);
}

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  final String _path = "auth";
  final ApiClient _client = ApiClient(baseUrl: 'http://127.0.0.1/api');

  @override
  Future<ResponseModel<bool>> signIn(String email, String password) async {
    try {
      final ResponseModel res = await _client
          .post('$_path/login', {'email': email, 'password': password});
      return ResponseModel(ok: res.result != null, result: res.result != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<bool>> signUp(String email, String password,
      {String name = ''}) async {
    try {
      final ResponseModel res = await _client.post('$_path/register',
          {'name': name, 'email': email, 'password': password});
      return ResponseModel(ok: res.result != null, result: res.result != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
