part of 'opciones_bloc.dart';

abstract class OpcionesEvent extends Equatable {
  const OpcionesEvent();

  @override
  List<Object> get props => [];
}

final class OptionsShown extends OpcionesEvent {}

final class OptionAddNew extends OpcionesEvent {
  final String name;
  final int orderMenu;
  final String page;

  const OptionAddNew({
    required this.name,
    required this.orderMenu,
    required this.page,
  });
}
