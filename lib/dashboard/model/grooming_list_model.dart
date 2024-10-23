class GroomingListModel {
  final int idcita;
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechahora;
  final String nombreMascota;
  final String nombreStatusCita;
  final String motivo;
  final String nombrePuesto;
  final String fechamodificacion;
  final int idempleado;
  final String nombreEmpleado;
  final String apellidoEmpleado;
  bool isHover;

  GroomingListModel({
    required this.idcita,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechahora,
    required this.nombreMascota,
    required this.nombreStatusCita,
    required this.motivo,
    required this.nombrePuesto,
    required this.fechamodificacion,
    required this.idempleado,
    required this.nombreEmpleado,
    required this.apellidoEmpleado,
    this.isHover = false,
  });

  factory GroomingListModel.fromJson(Map<String, dynamic> json) =>
      GroomingListModel(
        idcita: json["idcita"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechahora: json["fechahora"],
        nombreMascota: json["nombre_mascota"],
        nombreStatusCita: json["nombre_status_cita"],
        motivo: json["motivo"],
        nombrePuesto: json["nombre_puesto"],
        fechamodificacion: json["fechamodificacion"],
        idempleado: json["idempleado"],
        nombreEmpleado: json["nombre_empleado"],
        apellidoEmpleado: json["apellido_empleado"],
      );
}
