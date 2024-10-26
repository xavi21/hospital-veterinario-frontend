part of 'usuario_bloc.dart';

abstract class UsuarioState extends BaseState {}

class UsuarioInitial extends UsuarioState {}

final class UsuarioInProgress extends UsuarioState {}

final class UsuarioSuccess extends UsuarioState {
  final List<UsuarioListModel> usuarios;

  UsuarioSuccess({
    required this.usuarios,
  });
}

final class UsuarioError extends UsuarioState {
  final String message;

  UsuarioError({
    required this.message,
  });
}
