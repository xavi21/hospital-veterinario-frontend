part of 'opcion_usuario_bloc.dart';

abstract class OpcionUsuarioEvent extends Equatable {
  const OpcionUsuarioEvent();

  @override
  List<Object> get props => [];
}

final class UserOptionsShown extends OpcionUsuarioEvent {}

final class OptionsListShown extends OpcionUsuarioEvent {}

final class MenuListShown extends OpcionUsuarioEvent {}

final class UserOptionSaved extends OpcionUsuarioEvent {
  final String idUsuario;
  final int idMenu;
  final int idOpcion;
  final int alta;
  final int baja;
  final int cambio;

  const UserOptionSaved({
    required this.idUsuario,
    required this.idMenu,
    required this.idOpcion,
    required this.alta,
    required this.baja,
    required this.cambio,
  });
}

final class UserOptionEdited extends OpcionUsuarioEvent {
  final String idUsuario;
  final int idMenu;
  final int idOpcion;
  final int alta;
  final int baja;
  final int cambio;

  const UserOptionEdited({
    required this.idUsuario,
    required this.idMenu,
    required this.idOpcion,
    required this.alta,
    required this.baja,
    required this.cambio,
  });
}

final class UserOptionDeleted extends OpcionUsuarioEvent {
  final String idUsuario;
  final int idMenu;
  final int idOpcion;

  const UserOptionDeleted({
    required this.idUsuario,
    required this.idMenu,
    required this.idOpcion,
  });
}
