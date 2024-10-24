part of 'empleado_bloc.dart';

abstract class EmpleadoEvent extends Equatable {
  const EmpleadoEvent();

  @override
  List<Object> get props => [];
}

final class EmpleadoShown extends EmpleadoEvent {}

final class EmpleadoSaved extends EmpleadoEvent {
  final String name;
  final String lastName;
  final String birthDate;
  final String contractDate;
  final int idSucursal;
  final int idPuesto;
  final int idEstadoCivil;
  final int idGenero;
  final int idStatusEmpleado;

  const EmpleadoSaved({
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.contractDate,
    required this.idSucursal,
    required this.idPuesto,
    required this.idEstadoCivil,
    required this.idGenero,
    required this.idStatusEmpleado,
  });
}

final class EmpleadoEdited extends EmpleadoEvent {
  final int id;
  final String name;
  final String lastName;
  final String birthDate;
  final String contractDate;
  final int idSucursal;
  final int idPuesto;
  final int idEstadoCivil;
  final int idGenero;
  final int idStatusEmpleado;

  const EmpleadoEdited({
    required this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.contractDate,
    required this.idSucursal,
    required this.idPuesto,
    required this.idEstadoCivil,
    required this.idGenero,
    required this.idStatusEmpleado,
  });
}

final class EmpleadoDeleted extends EmpleadoEvent {
  final int id;

  const EmpleadoDeleted({
    required this.id,
  });
}
