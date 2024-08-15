import 'package:melo_cli/example/module/users/domain/models/user_model.dart';

import '../../../../commons/models/response.dart';
import '../repositories/i_users_repository.dart';

class DetailUserUsecase {
  final IUsersListRepository repository;
  DetailUserUsecase({required this.repository});

  Future<({Response response, UserModel? result})?> call(String id) async {
    var response = await repository.findById(id);
    return response;
  }
}
