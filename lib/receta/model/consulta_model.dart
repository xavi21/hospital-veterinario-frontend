class ConsultaModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String nombreMascota;
  final String fechamodificacion;
  final int idconsulta;
  final String nombreEmpleado;
  final String apellidoEmpleado;
  final int idreceta;
  final String observaciones;

  ConsultaModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.nombreMascota,
    required this.fechamodificacion,
    required this.idconsulta,
    required this.nombreEmpleado,
    required this.apellidoEmpleado,
    required this.idreceta,
    required this.observaciones,
  });

  factory ConsultaModel.fromJson(Map<String, dynamic> json) => ConsultaModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        nombreMascota: json["nombre_mascota"],
        fechamodificacion: json["fechamodificacion"],
        idconsulta: json["idconsulta"],
        nombreEmpleado: json["nombre_empleado"],
        apellidoEmpleado: json["apellido_empleado"],
        idreceta: json["idreceta"],
        observaciones: json["observaciones"],
      );
}
