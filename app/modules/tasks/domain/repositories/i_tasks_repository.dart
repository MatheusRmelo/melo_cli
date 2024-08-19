import '../models/task_model.dart';
import '../../../../commons/models/response.dart';

abstract class ITasksListRepository {
  Future<({Response response, List<TaskModel>? result})> findAll();
  Future<({Response response, TaskModel? result})> findById(String id);
  Future<({Response response, bool result})> update(String id, TaskModel body);

  Future<({Response response, bool result})> delete(String id);
  Future<({Response response, TaskModel? result})> create(TaskModel body);
}
