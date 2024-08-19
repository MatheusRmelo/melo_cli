import '../../../../commons/models/response.dart';
import '../models/task_model.dart';
import '../repositories/i_tasks_repository.dart';

class UpdateTaskUsecase {
  final ITasksListRepository repository;
  UpdateTaskUsecase({required this.repository});

  Future<({Response response, bool? result})> call(
      String id, TaskModel body) async {
    var response = await repository.update(id, body);
    return response;
  }
}
