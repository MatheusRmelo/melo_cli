import '../../../../commons/models/response.dart';
import '../models/user_model.dart';
import '../repositories/i_users_repository.dart';

class UpdateUserUsecase {
  final IUsersRepository repository;
  UpdateUserUsecase({required this.repository});

  Future<({Response response, bool? result})> call(
      String id, UserModel body) async {
    var response = await repository.update(id, body);
    return response;
  }
}
