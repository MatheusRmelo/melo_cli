part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashSuccess extends SplashState {
  bool isLogged;
  SplashSuccess({this.isLogged = false});
}

final class SplashError extends SplashState {
  final String message;
  SplashError(this.message);
}
