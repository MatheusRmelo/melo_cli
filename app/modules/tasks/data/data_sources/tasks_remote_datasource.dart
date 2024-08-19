import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../commons/models/response_model.dart';
import '../../domain/models/task_model.dart';

abstract class ITasksRemoteDataSource {
  Future<ResponseModel<List<TaskModel>>> findAll();
  Future<ResponseModel<TaskModel>> findById(String id);
  Future<ResponseModel<bool>> update(String id, TaskModel body);
  Future<ResponseModel<TaskModel>> create(TaskModel body);
  Future<ResponseModel<bool>> delete(String id);
}

class TasksRemoteDataSource implements ITasksRemoteDataSource {
  final String _table = "tasks";

  @override
  Future<ResponseModel<List<TaskModel>>> findAll() async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select();

    return ResponseModel(
        ok: true,
        result: (response as List).map((e) => TaskModel.fromJson(e)).toList());
  }

  @override
  Future<ResponseModel<TaskModel>> findById(String id) async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select().eq('id', id);

    return ResponseModel(ok: true, result: TaskModel.fromJson(response.first));
  }

  @override
  Future<ResponseModel<bool>> update(String id, TaskModel body) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from(_table).update(body.toJson()).eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<TaskModel>> create(TaskModel body) async {
    final supabase = Supabase.instance.client;
    try {
      var response = await supabase.from(_table).insert(body.toJson()).select();
      return ResponseModel(
          ok: true, result: TaskModel.fromJson(response.first));
    } catch (err) {
      return ResponseModel(
          ok: false, result: null, description: err.toString());
    }
  }

  @override
  Future<ResponseModel<bool>> delete(String id) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from(_table).delete().eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
