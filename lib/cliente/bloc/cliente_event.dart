part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

final class ClienteShown extends ClienteEvent {}

final class ClienteSaved extends ClienteEvent {
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final int idGenero;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final int idEstadoCivil;

  const ClienteSaved({
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

final class ClienteEdited extends ClienteEvent {
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

  const ClienteEdited({
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

final class ClienteDeleted extends ClienteEvent {
  final int clienteID;

  const ClienteDeleted({
    required this.clienteID,
  });
}
