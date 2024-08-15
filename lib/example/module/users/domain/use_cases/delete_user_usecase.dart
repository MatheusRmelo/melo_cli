import '../../../../commons/models/response.dart';
import '../repositories/i_users_repository.dart';

class DeleteUserUsecase {
  final IUsersListRepository repository;
  DeleteUserUsecase({required this.repository});

  Future<({Response response, bool? result})> call(String id) async {
    var response = await repository.delete(id);
    return response;
  }
}
