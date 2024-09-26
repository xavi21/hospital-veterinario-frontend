class CitaModel {
  final int idcita;
  final String nombreStatusCita;
  final String usuariomodificacion;
  final String fechamodificacion;
  final String fechahora;
  final int idmascota;
  final String nombreMascota;
  final int idstatuscita;
  final String motivo;
  final String usuariocreacion;
  final String fechacreacion;
  bool isHover;

  CitaModel({
    required this.idcita,
    required this.nombreStatusCita,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.fechahora,
    required this.idmascota,
    required this.nombreMascota,
    required this.idstatuscita,
    required this.motivo,
    required this.usuariocreacion,
    required this.fechacreacion,
    this.isHover = false,
  });

  factory CitaModel.fromJson(Map<String, dynamic> json) => CitaModel(
        idcita: json["idcita"],
        nombreStatusCita: json["nombre_status_cita"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        fechahora: json["fechahora"],
        idmascota: json["idmascota"],
        nombreMascota: json["nombre_mascota"],
        idstatuscita: json["idstatuscita"],
        motivo: json["motivo"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
      );
}
