import '../models/user_model.dart';
import '../../../../commons/models/response.dart';

abstract class IUsersRepository {
  Future<({Response response, List<UserModel>? result})> findAll();
  Future<({Response response, UserModel? result})> findById(String id);
  Future<({Response response, bool result})> update(String id, UserModel body);

  Future<({Response response, bool result})> delete(String id);
  Future<({Response response, UserModel? result})> create(UserModel body);
}
