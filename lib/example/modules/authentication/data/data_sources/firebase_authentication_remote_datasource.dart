import 'package:firebase_auth/firebase_auth.dart';
import '../../../../commons/models/response_model.dart';

abstract class IAuthenticationRemoteDataSource {
  Future<ResponseModel<bool>> signIn(String email, String password);
  Future<ResponseModel<bool>> signUp(String email, String password,
      {String? name});
}

class AuthenticationRemoteDataSource
    implements IAuthenticationRemoteDataSource {
  final _firebase = FirebaseAuth.instance;

  @override
  Future<ResponseModel<bool>> signIn(String email, String password) async {
    try {
      final UserCredential res = await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
      return ResponseModel(ok: res.user != null, result: res.user != null);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<bool>> signUp(String email, String password,
      {String? name}) async {
    try {
      final UserCredential res = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      if (name != null) {
        await res.user!.updateDisplayName(name);
      }
      return ResponseModel(ok: res.user != null, result: res.user != null);
    } on FirebaseAuthException catch (error) {
      String message = "Falha desconhecida";
      switch (error.code) {
        case 'weak-password':
          message = "Sua senha precisa ter no mínimo 6 caracteres";
          break;
        case 'invalid-email':
          message = "Informe um e-mail válido, por favor.";
          break;
        case 'email-already-in-use':
          message = "Esse e-mail não está disponível";
          break;
        case 'operation-not-allowed':
          message = "Operação não permita no servidor, contate o admin!";
          break;
      }
      return ResponseModel(ok: false, result: false, description: message);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
