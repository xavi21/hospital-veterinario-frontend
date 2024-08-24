part of 'login_bloc.dart';

abstract class LoginState extends BaseState {}

final class LoginInitial extends LoginState {}

final class LoginInProgress extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess({
    required this.loginResponse,
  });
}

final class LoginError extends LoginState {
  final String error;

  LoginError({
    required this.error,
  });
}
