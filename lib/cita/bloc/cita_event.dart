part of 'cita_bloc.dart';

abstract class CitaEvent extends Equatable {
  const CitaEvent();

  @override
  List<Object> get props => [];
}

final class CitaShown extends CitaEvent {}

final class MascotaListShown extends CitaEvent {}

final class StatusCitaListShown extends CitaEvent {}

final class CitaSaved extends CitaEvent {
  final int idMascota;
  final int idStatusCita;
  final String motivo;

  const CitaSaved({
    required this.idMascota,
    required this.idStatusCita,
    required this.motivo,
  });
}

final class CitaEdited extends CitaEvent {
  final int idCita;
  final int idMascota;
  final int idStatusCita;
  final String motivo;

  const CitaEdited({
    required this.idCita,
    required this.idMascota,
    required this.idStatusCita,
    required this.motivo,
  });
}

final class CitaDeleted extends CitaEvent {
  final int citaId;

  const CitaDeleted({
    required this.citaId,
  });
}
