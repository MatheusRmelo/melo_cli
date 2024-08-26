import '../../../../commons/models/response.dart';
import '../../../../commons/models/response_model.dart';
import '../repositories/i_authentication_repository.dart';

class SignUpUsecase {
  final IAuthenticationRepository repository;
  SignUpUsecase({required this.repository});

  Future<({String? error, List<ErrorFieldModel>? errorsFields})> call(
      {required String email, required String password}) async {
    List<ErrorFieldModel> errors = [];
    if (email.isEmpty) {
      errors.add(ErrorFieldModel(
          key: 'email', errors: ['E-mail é uma informação obrigatória']));
    }
    if (password.isEmpty) {
      errors.add(ErrorFieldModel(
          key: 'password', errors: ['Senha é uma informação obrigatória']));
    }
    if (errors.isNotEmpty) {
      return (error: null, errorsFields: errors);
    }
    var result = await repository.signIn(email, password);
    if (result.response is Success) {
      return (error: null, errorsFields: null);
    } else if (result.response is ErrorResponse) {
      return (
        error: (result.response as ErrorResponse).error,
        errorsFields: null
      );
    }
    return (error: 'Falha ao fazer login', errorsFields: null);
  }
}
