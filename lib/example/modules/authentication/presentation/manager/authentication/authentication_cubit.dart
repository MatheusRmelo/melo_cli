import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/response_model.dart';
import '../../../domain/use_cases/signin_usecase.dart';
import '../../../domain/use_cases/signup_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;

  AuthenticationCubit(
      {required this.signInUsecase, required this.signUpUsecase})
      : super(AuthenticationInitial());

  Future<void> handleClickSignIn(
      {required String email, required String password}) async {
    emit(AuthenticationLoading());
    var result = await signInUsecase.call(email: email, password: password);
    if (result.error != null) {
      emit(AuthenticationError(result.error!));
    } else if (result.errorsFields != null) {
      emit(AuthenticationErrorField(result.errorsFields!));
    } else {
      emit(AuthenticationSuccess());
    }
  }

  Future<void> handleClickSignUp(
      {required String email, required String password}) async {
    emit(AuthenticationLoading());
    var result = await signUpUsecase.call(email: email, password: password);
    if (result.error != null) {
      emit(AuthenticationError(result.error!));
    } else if (result.errorsFields != null) {
      emit(AuthenticationErrorField(result.errorsFields!));
    } else {
      emit(AuthenticationSuccess());
    }
  }
}
