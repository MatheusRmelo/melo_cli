import '../../../../core/network/remote/api_client.dart';

import '../../../../commons/models/response_model.dart';
import '../../domain/models/user_model.dart';

abstract class IUsersRemoteDataSource {
  Future<ResponseModel<List<UserModel>>> findAll();
  Future<ResponseModel<UserModel>> findById(String id);
  Future<ResponseModel<bool>> update(String id, UserModel body);
  Future<ResponseModel<UserModel>> create(UserModel body);
  Future<ResponseModel<bool>> delete(String id);
}

class UsersRemoteDataSource implements IUsersRemoteDataSource {
  final String _path = "users";
  final ApiClient _client = ApiClient(baseUrl: 'http://127.0.0.1/api');

  @override
  Future<ResponseModel<List<UserModel>>> findAll() async {
    var response = await _client.get(_path);

    return ResponseModel(
        ok: true,
        result: (response.result as List)
            .map((e) => UserModel.fromJson(e))
            .toList());
  }

  @override
  Future<ResponseModel<UserModel>> findById(String id) async {
    var response = await _client.get("$_path/$id");

    return ResponseModel(ok: true, result: UserModel.fromJson(response.result));
  }

  @override
  Future<ResponseModel<bool>> update(String id, UserModel body) async {
    try {
      await _client.put("$_path/$id", body.toJson());
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<UserModel>> create(UserModel body) async {
    try {
      var response = await _client.post(_path, body.toJson());
      return ResponseModel(
          ok: true, result: UserModel.fromJson(response.result));
    } catch (err) {
      return ResponseModel(
          ok: false, result: null, description: err.toString());
    }
  }

  @override
  Future<ResponseModel<bool>> delete(String id) async {
    try {
      await _client.delete("$_path/$id");
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
