part of 'opcion_usuario_bloc.dart';

abstract class OpcionUsuarioEvent extends Equatable {
  const OpcionUsuarioEvent();

  @override
  List<Object> get props => [];
}

final class UserOptionsShown extends OpcionUsuarioEvent {}
