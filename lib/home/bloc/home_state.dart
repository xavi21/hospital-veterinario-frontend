part of 'home_bloc.dart';

abstract class HomeState extends BaseState {}

final class HomeInitial extends HomeState {}

final class HomeinProgress extends HomeState {}

final class HomeGetMenuSuccess extends HomeState {
  final List<MenuListModel> menu;
  final List<SubMenuListModel> subMenu;
  final String userEmail;

  HomeGetMenuSuccess({
    required this.menu,
    required this.subMenu,
    required this.userEmail,
  });
}

final class HomeServiceError extends HomeState {
  final String message;

  HomeServiceError({
    required this.message,
  });
}
