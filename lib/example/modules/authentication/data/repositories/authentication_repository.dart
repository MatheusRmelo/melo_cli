import '../../../../commons/models/response.dart';
import '../../domain/repositories/i_authentication_repository.dart';
import '../data_sources/authentication_remote_datasource.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationRemoteDataSource remoteDataSource;
  AuthenticationRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({Response response, bool result})> signIn(
      String email, String password) async {
    var response = await remoteDataSource.signIn(email, password);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }

  @override
  Future<({Response response, bool result})> signUp(
      String email, String password) async {
    var response = await remoteDataSource.signUp(email, password);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }
}
