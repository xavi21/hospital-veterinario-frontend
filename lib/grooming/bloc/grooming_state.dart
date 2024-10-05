part of 'grooming_bloc.dart';

abstract class GroomingState extends BaseState {}

class GroomingInitial extends GroomingState {}

final class GroomingInProgress extends GroomingState {}

final class GroomingSuccess extends GroomingState {
  final List<GroomingListModel> groomings;

  GroomingSuccess({
    required this.groomings,
  });
}

final class GroomingCitaListSuccess extends GroomingState {
  final List<CitaModel> citas;

  GroomingCitaListSuccess({
    required this.citas,
  });
}

final class GroomingEmpleadoListSuccess extends GroomingState {
  final List<EmpleadoModel> empleados;

  GroomingEmpleadoListSuccess({
    required this.empleados,
  });
}

final class GroomingCreatedSuccess extends GroomingState {}

final class GroomingEditedSuccess extends GroomingState {}

final class GroomingDeletedSuccess extends GroomingState {}

final class GroomingServiceError extends GroomingState {
  final String message;

  GroomingServiceError({
    required this.message,
  });
}
