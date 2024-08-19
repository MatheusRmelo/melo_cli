import '../../../../commons/models/response.dart';
import '../../domain/models/task_model.dart';
import '../../domain/repositories/i_tasks_repository.dart';
import '../data_sources/tasks_remote_datasource.dart';

class TasksRepository implements ITasksListRepository {
  final ITasksRemoteDataSource remoteDataSource;
  TasksRepository({
    required this.remoteDataSource,
  });

  @override
  Future<({Response response, List<TaskModel>? result})> findAll() async {
    var response = await remoteDataSource.findAll();
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, TaskModel? result})> findById(String id) async {
    var response = await remoteDataSource.findById(id);
    return (response: Success(), result: response.result);
  }

  @override
  Future<({Response response, bool result})> update(
      String id, TaskModel body) async {
    var response = await remoteDataSource.update(id, body);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }

  @override
  Future<({Response response, TaskModel? result})> create(
      TaskModel body) async {
    var response = await remoteDataSource.create(body);
    return (
      response: response.result == null
          ? ErrorResponse(response.description)
          : Success(),
      result: response.result
    );
  }

  @override
  Future<({Response response, bool result})> delete(String id) async {
    var response = await remoteDataSource.delete(id);
    return (
      response: (response.result ?? false)
          ? Success()
          : ErrorResponse(response.description),
      result: response.result ?? false
    );
  }
}
