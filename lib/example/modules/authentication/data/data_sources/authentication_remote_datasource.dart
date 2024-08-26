import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../commons/models/response_model.dart';

abstract class IAuthenticationRemoteDataSource {
  Future<ResponseModel<bool>> signIn(String email, String password);
  Future<ResponseModel<bool>> signUp(String email, String password);
}

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<ResponseModel<bool>> signIn(String email, String password) async {
    try {
      final AuthResponse res = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      return ResponseModel(ok: res.user != null, result: res.user != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<bool>> signUp(String email, String password) async {
    try {
      final AuthResponse res =
          await _supabase.auth.signUp(email: email, password: password);
      return ResponseModel(ok: res.user != null, result: res.user != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
