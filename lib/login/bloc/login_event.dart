part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginOnLoad extends LoginEvent {}

final class LoginWithEmailPassword extends LoginEvent {
  final String codeEmail;
  final String password;

  const LoginWithEmailPassword({
    required this.codeEmail,
    required this.password,
  });
}
