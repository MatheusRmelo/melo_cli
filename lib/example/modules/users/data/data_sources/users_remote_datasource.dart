import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../commons/models/response_model.dart';
import '../../domain/models/user_model.dart';

abstract class IUsersRemoteDataSource {
  Future<ResponseModel<List<UserModel>>> findAll();
  Future<ResponseModel<UserModel>> findById(String id);
  Future<ResponseModel<bool>> update(String id, UserModel body);
  Future<ResponseModel<UserModel>> create(UserModel body);
  Future<ResponseModel<bool>> delete(String id);
}

class UsersRemoteDataSource implements IUsersRemoteDataSource {
  final String _table = "users";

  @override
  Future<ResponseModel<List<UserModel>>> findAll() async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select();

    return ResponseModel(
        ok: true,
        result: (response as List).map((e) => UserModel.fromJson(e)).toList());
  }

  @override
  Future<ResponseModel<UserModel>> findById(String id) async {
    final supabase = Supabase.instance.client;
    var response = await supabase.from(_table).select().eq('id', id);

    return ResponseModel(ok: true, result: UserModel.fromJson(response.first));
  }

  @override
  Future<ResponseModel<bool>> update(String id, UserModel body) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase.from(_table).update(body.toJson()).eq('id', id);
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<UserModel>> create(UserModel body) async {
    final supabase = Supabase.instance.client;
    try {
      var response = await supabase.from(_table).insert(body.toJson()).select();
      return ResponseModel(
          ok: true, result: UserModel.fromJson(response.first));
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
