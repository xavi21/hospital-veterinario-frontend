part of 'cita_bloc.dart';

abstract class CitaState extends BaseState {}

final class CitaInitial extends CitaState {}

final class CitaInProgress extends CitaState {}

final class CitaSuccess extends CitaState {
  final List<CitaListModel> citas;

  CitaSuccess({
    required this.citas,
  });
}

final class MascotaSuccess extends CitaState {
  final List<MascotaListModel> mascotas;

  MascotaSuccess({
    required this.mascotas,
  });
}

final class StatucCitaSuccess extends CitaState {
  final List<StatusCitaListModel> statusCitas;

  StatucCitaSuccess({
    required this.statusCitas,
  });
}

final class CitaCreatedSuccess extends CitaState {}

final class CitaEditedSuccess extends CitaState {}

final class CitaDeletedSuccess extends CitaState {}

final class CitaError extends CitaState {
  final String message;

  CitaError({
    required this.message,
  });
}
