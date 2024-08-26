import '../../../../commons/models/response.dart';
import '../models/user_model.dart';
import '../repositories/i_users_repository.dart';

class ListUserUsecase {
  final IUsersRepository repository;
  ListUserUsecase({required this.repository});

  Future<({Response response, List<UserModel>? result})> call() async {
    var response = await repository.findAll();
    return response;
  }
}
