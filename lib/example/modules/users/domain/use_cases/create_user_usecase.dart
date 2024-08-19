import '../../../../commons/models/response.dart';
import '../models/user_model.dart';
import '../repositories/i_users_repository.dart';

class CreateUserUsecase {
  final IUsersListRepository repository;
  CreateUserUsecase({required this.repository});

  Future<({Response response, UserModel? result})> call(UserModel body) async {
    var response = await repository.create(body);
    return response;
  }
}
