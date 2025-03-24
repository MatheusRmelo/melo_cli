import '../../../../core/network/remote/api_client.dart';
import '../../../../commons/models/response_model.dart';

abstract class ISplashRemoteDataSource {
  Future<ResponseModel<bool>> checkIsLogged();
}

class SplashRemoteDataSource implements ISplashRemoteDataSource {
  final String _path = "auth";
  final ApiClient _client = ApiClient(baseUrl: 'http://127.0.0.1/api');

  @override
  Future<ResponseModel<bool>> checkIsLogged() async {
    try {
      final ResponseModel res = await _client.get('$_path/user/me');
      return ResponseModel(ok: res.result != null, result: res.result != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
