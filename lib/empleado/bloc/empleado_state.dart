part of 'empleado_bloc.dart';

abstract class EmpleadoState extends BaseState {}

class EmpleadoInitial extends EmpleadoState {}

final class EmpleadoInProgress extends EmpleadoState {}

final class EmpleadoSuccess extends EmpleadoState {
  final List<EmpleadoListModel> empleados;

  EmpleadoSuccess({
    required this.empleados,
  });
}

final class EmpleadoCreatedSuccess extends EmpleadoState {}

final class EmpleadoEditedSuccess extends EmpleadoState {}

final class EmpleadoDeletedSuccess extends EmpleadoState {}

final class EmpleadoError extends EmpleadoState {
  final String message;

  EmpleadoError({
    required this.message,
  });
}
