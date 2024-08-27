part of 'login_bloc.dart';

abstract class LoginState extends BaseState {}

final class LoginInitial extends LoginState {}

final class LoginInProgress extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginReminderMailSuccess extends LoginState {
  final String reminderMail;

  LoginReminderMailSuccess({
    required this.reminderMail,
  });
}

final class LoginError extends LoginState {
  final String error;

  LoginError({
    required this.error,
  });
}
