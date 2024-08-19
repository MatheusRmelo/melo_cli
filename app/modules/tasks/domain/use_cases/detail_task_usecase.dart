import '../../../../commons/models/response.dart';
import '../models/task_model.dart';
import '../repositories/i_tasks_repository.dart';

class DetailTaskUsecase {
  final ITasksListRepository repository;
  DetailTaskUsecase({required this.repository});

  Future<({Response response, TaskModel? result})?> call(String id) async {
    var response = await repository.findById(id);
    return response;
  }
}
