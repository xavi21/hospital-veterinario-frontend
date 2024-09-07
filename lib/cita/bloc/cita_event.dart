part of 'cita_bloc.dart';

abstract class CitaEvent extends Equatable {
  const CitaEvent();

  @override
  List<Object> get props => [];
}

final class CitaShown extends CitaEvent {}

final class CitaSaved extends CitaEvent {
  final String name;

  const CitaSaved({
    required this.name,
  });
}

final class CitaEdited extends CitaEvent {
  final int id;
  final String name;

  const CitaEdited({
    required this.id,
    required this.name,
  });
}

final class CitaDeleted extends CitaEvent {
  final int citaId;

  const CitaDeleted({
    required this.citaId,
  });
}
