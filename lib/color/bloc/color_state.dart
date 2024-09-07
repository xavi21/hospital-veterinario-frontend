part of 'color_bloc.dart';

abstract class ColorState extends BaseState {}

final class ColorInitial extends ColorState {}

final class ColorInProgress extends ColorState {}

final class ColorSuccess extends ColorState {
  final List<ColorListModel> colores;

  ColorSuccess({
    required this.colores,
  });
}

final class ColorCreatedSuccess extends ColorState {}

final class ColorEditedSuccess extends ColorState {}

final class ColorDeletedSuccess extends ColorState {}

final class ColorError extends ColorState {
  final String message;

  ColorError({
    required this.message,
  });
}
