part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();

  @override
  List<Object> get props => [];
}

final class ColorShown extends ColorEvent {}

final class ColorSaved extends ColorEvent {
  final String name;

  const ColorSaved({
    required this.name,
  });
}

final class ColorEdited extends ColorEvent {
  final int id;
  final String name;

  const ColorEdited({
    required this.id,
    required this.name,
  });
}

final class ColorDeleted extends ColorEvent {
  final int colorId;

  const ColorDeleted({
    required this.colorId,
  });
}
