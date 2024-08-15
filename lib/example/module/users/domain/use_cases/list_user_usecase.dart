import 'package:melo_cli/example/module/users/domain/models/user_model.dart';

import '../../../../commons/models/response.dart';
import '../repositories/i_users_repository.dart';

class ListUserUsecase {
  final IUsersListRepository repository;
  ListUserUsecase({required this.repository});

  Future<({Response response, List<UserModel>? result})> call() async {
    var response = await repository.findAll();
    return response;
  }
}
