part of 'users_form_cubit.dart';

sealed class UsersFormState {}

final class UsersFormInitial extends UsersFormState {}

final class UsersFormLoading extends UsersFormState {}

final class UsersFormBusy extends UsersFormState {}

final class UsersFormDetailSuccess extends UsersFormState {
  final UserModel data;
  UsersFormDetailSuccess(this.data);
}

final class UsersFormSuccess extends UsersFormState {
  UsersFormSuccess();
}

final class UsersFormError extends UsersFormState {
  final String message;
  UsersFormError(this.message);
}
