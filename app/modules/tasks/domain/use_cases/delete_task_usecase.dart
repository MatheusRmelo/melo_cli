import '../../../../commons/models/response.dart';
import '../repositories/i_tasks_repository.dart';

class DeleteTaskUsecase {
  final ITasksListRepository repository;
  DeleteTaskUsecase({required this.repository});

  Future<({Response response, bool? result})> call(String id) async {
    var response = await repository.delete(id);
    return response;
  }
}
