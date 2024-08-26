import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/response.dart';
import '../../../domain/models/user_model.dart';
import '../../../domain/use_cases/delete_user_usecase.dart';
import '../../../domain/use_cases/list_user_usecase.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final ListUserUsecase listUserUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  UsersCubit({required this.listUserUsecase, required this.deleteUserUsecase})
      : super(UsersInitial());

  Future<void> findAll() async {
    emit(UsersLoading());
    var response = await listUserUsecase.call();
    if (response is ErrorResponse) {
      emit(UsersError((response.response as ErrorResponse).error));
    } else {
      emit(UsersSuccess(response.result!));
    }
  }

  Future<void> delete(String id) async {
    emit(UsersLoading());
    var response = await deleteUserUsecase.call(id);
    if (response is ErrorResponse) {
      emit(UsersError((response.response as ErrorResponse).error));
    } else {
      findAll();
    }
  }
}
