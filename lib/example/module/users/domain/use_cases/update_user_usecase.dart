import 'package:melo_cli/example/module/users/domain/models/user_model.dart';

import '../../../../commons/models/response.dart';
import '../repositories/i_users_repository.dart';

class UpdateUserUsecase {
  final IUsersListRepository repository;
  UpdateUserUsecase({required this.repository});

  Future<({Response response, bool? result})> call(
      String id, UserModel body) async {
    var response = await repository.update(id, body);
    return response;
  }
}
