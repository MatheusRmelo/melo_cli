import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../commons/models/dynamic_field_model.dart';
import '../../../../../commons/models/response.dart';
import '../../../domain/models/user_model.dart';
import '../../../domain/use_cases/create_user_usecase.dart';
import '../../../domain/use_cases/detail_user_usecase.dart';
import '../../../domain/use_cases/list_user_dynamic_fields_usecase.dart';
import '../../../domain/use_cases/update_user_usecase.dart';

part 'users_form_state.dart';

class UsersFormCubit extends Cubit<UsersFormState> {
  final DetailUserUsecase detailUserUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final CreateUserUsecase createUserUsecase;
  final ListUserDynamicFieldsUsecase listUserDynamicFieldsUsecase;

  UsersFormCubit(
      {required this.detailUserUsecase,
      required this.updateUserUsecase,
      required this.createUserUsecase,
      required this.listUserDynamicFieldsUsecase})
      : super(UsersFormInitial());

  List<DynamicFieldModel> getFields() => listUserDynamicFieldsUsecase.call();

  Future<void> findById(String id) async {
    emit(UsersFormLoading());
    var data = await detailUserUsecase.call(id);
    if (data!.response is Success) {
      emit(UsersFormDetailSuccess(data.result!));
    } else if (data.response is ErrorResponse) {
      emit(UsersFormError((data.response as ErrorResponse).error));
    }
  }

  Future<void> save(UserModel body, {String? id}) async {
    emit(UsersFormBusy());
    Response response = Success();
    if (id != null) {
      response = (await updateUserUsecase.call(id, body)).response;
    } else {
      response = (await createUserUsecase.call(body)).response;
    }

    if (response is Success) {
      emit(UsersFormSuccess());
    } else if (response is ErrorResponse) {
      emit(UsersFormError(response.error));
    }
  }
}
