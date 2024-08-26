import '../../../../commons/models/response.dart';
import '../models/user_model.dart';
import '../repositories/i_users_repository.dart';

class DetailUserUsecase {
  final IUsersRepository repository;
  DetailUserUsecase({required this.repository});

  Future<({Response response, UserModel? result})?> call(String id) async {
    var response = await repository.findById(id);
    return response;
  }
}
