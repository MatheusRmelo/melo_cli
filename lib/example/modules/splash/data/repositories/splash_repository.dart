import '../../../../commons/models/response.dart';
import '../../domain/repositories/i_splash_repository.dart';
import '../data_sources/api_splash_remote_datasource.dart';

class SplashRepository implements ISplashRepository {
  final ISplashRemoteDataSource remoteDataSource;
  SplashRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({Response response, bool result})> checkIsLogged() async {
    var response = await remoteDataSource.checkIsLogged();
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }
}
