class EmpleadoListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final int idempleado;
  final String nombreEmpleado;
  final String apellidoEmpleado;
  final String fechanacimiento;
  final String fechacontratacion;
  final int idestadocivil;
  final String nombreEstadoCivil;
  final int idgenero;
  final String nombreGenero;
  final int idpuesto;
  final String nombrePuesto;
  final int idstatusempleado;
  final String nombreStatusEmpleado;
  final int idsucursal;
  final String nombreSucursal;
  bool isHover;

  EmpleadoListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.idempleado,
    required this.nombreEmpleado,
    required this.apellidoEmpleado,
    required this.fechanacimiento,
    required this.fechacontratacion,
    required this.idestadocivil,
    required this.nombreEstadoCivil,
    required this.idgenero,
    required this.nombreGenero,
    required this.idpuesto,
    required this.nombrePuesto,
    required this.idstatusempleado,
    required this.nombreStatusEmpleado,
    required this.idsucursal,
    required this.nombreSucursal,
    this.isHover = false,
  });

  factory EmpleadoListModel.fromJson(Map<String, dynamic> json) =>
      EmpleadoListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        idempleado: json["idempleado"],
        nombreEmpleado: json["nombre_empleado"],
        apellidoEmpleado: json["apellido_empleado"],
        fechanacimiento: json["fechanacimiento"],
        fechacontratacion: json["fechacontratacion"],
        idestadocivil: json["idestadocivil"],
        nombreEstadoCivil: json["nombre_estado_civil"],
        idgenero: json["idgenero"],
        nombreGenero: json["nombre_genero"],
        idpuesto: json["idpuesto"],
        nombrePuesto: json["nombre_puesto"],
        idstatusempleado: json["idstatusempleado"],
        nombreStatusEmpleado: json["nombre_status_empleado"],
        idsucursal: json["idsucursal"],
        nombreSucursal: json["nombre_sucursal"],
      );
}
