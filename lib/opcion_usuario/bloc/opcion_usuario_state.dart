part of 'opcion_usuario_bloc.dart';

abstract class OpcionUsuarioState extends BaseState {}

final class OpcionUsuarioInitial extends OpcionUsuarioState {}

final class OpcionUsuarioInProgress extends OpcionUsuarioState {}

final class OpcionUsuarioListSuccess extends OpcionUsuarioState {
  final List<OpcionUsuarioModel> opcionesList;

  OpcionUsuarioListSuccess({
    required this.opcionesList,
  });
}

final class OpcionUsuarioCreatedSuccess extends OpcionUsuarioState {}

final class OpcionUsuarioEditedSuccess extends OpcionUsuarioState {}

final class OpcionUsuarioDeletedSuccess extends OpcionUsuarioState {}

final class OpcionUsuarioServiceError extends OpcionUsuarioState {
  final String message;

  OpcionUsuarioServiceError({
    required this.message,
  });
}
