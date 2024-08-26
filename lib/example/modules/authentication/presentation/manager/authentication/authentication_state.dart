part of 'authentication_cubit.dart';

sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  AuthenticationSuccess();
}

final class AuthenticationError extends AuthenticationState {
  final String message;
  AuthenticationError(this.message);
}

final class AuthenticationErrorField extends AuthenticationState {
  final List<ErrorFieldModel> errors;
  AuthenticationErrorField(this.errors);
}
