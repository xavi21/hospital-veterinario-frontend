part of 'statusempleado_bloc.dart';

abstract class StatusEmpleadoEvent extends Equatable {
  const StatusEmpleadoEvent();

  @override
  List<Object> get props => [];
}

final class StatusEmpleadoShown extends StatusEmpleadoEvent {}

final class StatusEmpleadoSaved extends StatusEmpleadoEvent {
  final String name;

  const StatusEmpleadoSaved({
    required this.name,
  });
}

final class StatusEmpleadoEdited extends StatusEmpleadoEvent {
  final int id;
  final String name;

  const StatusEmpleadoEdited({
    required this.id,
    required this.name,
  });
}

final class StatusEmpleadoDeleted extends StatusEmpleadoEvent {
  final int statusEmpleadoID;

  const StatusEmpleadoDeleted({
    required this.statusEmpleadoID,
  });
}
