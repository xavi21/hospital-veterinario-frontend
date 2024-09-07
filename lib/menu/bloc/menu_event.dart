part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

final class MenuListShown extends MenuEvent {}

final class MenuSaved extends MenuEvent {
  final String name;
  final int orderMenu;

  const MenuSaved({
    required this.name,
    required this.orderMenu,
  });
}

final class MenuEdited extends MenuEvent {
  final int id;
  final String name;
  final int orderMenu;

  const MenuEdited({
    required this.id,
    required this.name,
    required this.orderMenu,
  });
}

final class MenuDeleted extends MenuEvent {
  final int menuID;

  const MenuDeleted({
    required this.menuID,
  });
}
