part of 'statusempleado_bloc.dart';

abstract class StatusEmpleadoState extends BaseState {}

final class StatusEmpleadoInitial extends StatusEmpleadoState {}

final class StatusEmpleadoInProgress extends StatusEmpleadoState {}

final class StatusEmpleadoSuccess extends StatusEmpleadoState {
  final List<StatusEmpleadoListModel> statusEmpleados;

  StatusEmpleadoSuccess({
    required this.statusEmpleados,
  });
}

final class StatusEmpleadoCreatedSuccess extends StatusEmpleadoState {}

final class StatusEmpleadoEditedSuccess extends StatusEmpleadoState {}

final class StatusEmpleadoDeletedSuccess extends StatusEmpleadoState {}

final class StatusEmpleadoError extends StatusEmpleadoState {
  final String message;

  StatusEmpleadoError({
    required this.message,
  });
}
