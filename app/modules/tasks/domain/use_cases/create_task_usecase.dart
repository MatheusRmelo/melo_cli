import '../../../../commons/models/response.dart';
import '../models/task_model.dart';
import '../repositories/i_tasks_repository.dart';

class CreateTaskUsecase {
  final ITasksListRepository repository;
  CreateTaskUsecase({required this.repository});

  Future<({Response response, TaskModel? result})> call(TaskModel body) async {
    var response = await repository.create(body);
    return response;
  }
}
