part of 'opciones_bloc.dart';

abstract class OpcionesEvent extends Equatable {
  const OpcionesEvent();

  @override
  List<Object> get props => [];
}

final class OptionsShown extends OpcionesEvent {}

final class OptionCreated extends OpcionesEvent {
  final String name;
  final int orderMenu;
  final String page;

  const OptionCreated({
    required this.name,
    required this.orderMenu,
    required this.page,
  });
}

final class OptionEdited extends OpcionesEvent {
  final int id;
  final String name;
  final int orderMenu;
  final String page;

  const OptionEdited({
    required this.id,
    required this.name,
    required this.orderMenu,
    required this.page,
  });
}

final class OptionDeleted extends OpcionesEvent {
  final int id;

  const OptionDeleted({
    required this.id,
  });
}
