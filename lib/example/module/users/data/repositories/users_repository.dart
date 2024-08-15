import 'package:melo_cli/example/module/users/domain/models/user_model.dart';

import '../../../../commons/models/response.dart';
import '../../domain/repositories/i_users_repository.dart';
import '../data_sources/users_remote_datasource.dart';

class UsersRepository implements IUsersListRepository {
  final IUsersRemoteDataSource remoteDataSource;
  UsersRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({Response response, List<UserModel>? result})> findAll() async {
    var response = await remoteDataSource.findAll();
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, UserModel? result})> findById(String id) async {
    var response = await remoteDataSource.findById(id);
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, bool result})> update(
      String id, UserModel body) async {
    var response = await remoteDataSource.update(id, body);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }

  @override
  Future<({Response response, UserModel? result})> create(
      UserModel body) async {
    var response = await remoteDataSource.create(body);
    return (
      response: response.result == null
          ? ErrorResponse(response.description)
          : Success(),
      result: response.result
    );
  }

  @override
  Future<({Response response, bool result})> delete(String id) async {
    var response = await remoteDataSource.delete(id);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }
}
