part of 'opciones_bloc.dart';

abstract class OpcionesEvent extends Equatable {
  const OpcionesEvent();

  @override
  List<Object> get props => [];
}

final class OptionsShown extends OpcionesEvent {}
