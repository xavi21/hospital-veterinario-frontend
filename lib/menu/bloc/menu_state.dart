part of 'menu_bloc.dart';

abstract class MenuState extends BaseState {}

final class MenuInitial extends MenuState {}

final class MenuInProgress extends MenuState {}

final class MenuListSuccess extends MenuState {
  final List<MenuModel> menuList;

  MenuListSuccess({
    required this.menuList,
  });
}

final class MenuServiceError extends MenuState {
  final String message;

  MenuServiceError({
    required this.message,
  });
}
