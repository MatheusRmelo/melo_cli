import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/response.dart';
import '../../../domain/use_cases/check_is_logged_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckIsLoggedUsecase checkIsLoggedUsecase;

  SplashCubit({required this.checkIsLoggedUsecase}) : super(SplashInitial());

  Future<void> checkIsLogged() async {
    emit(SplashLoading());
    var result = await checkIsLoggedUsecase.call();
    if (result.response is Success) {
      emit(SplashSuccess(isLogged: result.result ?? false));
    } else if (result.response is ErrorResponse) {
      emit(SplashError((result.response as ErrorResponse).error));
    }
  }
}
