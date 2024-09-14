part of 'persona_bloc.dart';

abstract class PersonaEvent extends Equatable {
  const PersonaEvent();

  @override
  List<Object> get props => [];
}

final class PersonaShown extends PersonaEvent {}

final class PersonaSaved extends PersonaEvent {
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final int idGenero;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final int idEstadoCivil;

  const PersonaSaved({
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.idGenero,
    required this.direccion,
    required this.telefono,
    required this.correoElectronico,
    required this.idEstadoCivil,
  });
}

final class PersonaEdited extends PersonaEvent {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idpersona;
  final String nombre;
  final String apellido;
  final String fechanacimiento;
  final int idGenero;
  final String direccion;
  final String telefono;
  final String correoelectronico;
  final int idEstadoCivil;

  const PersonaEdited({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idpersona,
    required this.nombre,
    required this.apellido,
    required this.fechanacimiento,
    required this.idGenero,
    required this.direccion,
    required this.telefono,
    required this.correoelectronico,
    required this.idEstadoCivil,
  });
}

final class PersonaDeleted extends PersonaEvent {
  final int id;

  const PersonaDeleted({
    required this.id,
  });
}
