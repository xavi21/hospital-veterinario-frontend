part of 'usuario_bloc.dart';

abstract class UsuarioEvent extends Equatable {
  const UsuarioEvent();

  @override
  List<Object> get props => [];
}

final class UsuarioShown extends UsuarioEvent {}
