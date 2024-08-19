import '../../../../commons/models/response.dart';
import '../models/task_model.dart';
import '../repositories/i_tasks_repository.dart';

class ListTaskUsecase {
  final ITasksListRepository repository;
  ListTaskUsecase({required this.repository});

  Future<({Response response, List<TaskModel>? result})> call() async {
    var response = await repository.findAll();
    return response;
  }
}
