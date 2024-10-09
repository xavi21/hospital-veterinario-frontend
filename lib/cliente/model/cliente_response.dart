class ClienteListModel {
  final int idcita;
  final String usuariomodificacion;
  final String fechamodificacion;
  final String fechahora;
  final String nombreMascota;
  final String motivo;
  final String usuariocreacion;
  final String fechacreacion;
  final int idcliente;
  final int idempleado;
  final String nombreEmpleado;
  final String apellidoEmpleado;
  final String sintomas;
  final String diagnostico;
  bool isHover;

  ClienteListModel({
    required this.idcita,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.fechahora,
    required this.nombreMascota,
    required this.motivo,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.idcliente,
    required this.idempleado,
    required this.nombreEmpleado,
    required this.apellidoEmpleado,
    required this.sintomas,
    required this.diagnostico,
    this.isHover = false,
  });

  factory ClienteListModel.fromJson(Map<String, dynamic> json) =>
      ClienteListModel(
        idcita: json["idcita"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        fechahora: json["fechahora"],
        nombreMascota: json["nombre_mascota"],
        motivo: json["motivo"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        idcliente: json["idcliente"],
        idempleado: json["idempleado"],
        nombreEmpleado: json["nombre_empleado"],
        apellidoEmpleado: json["apellido_empleado"],
        sintomas: json["sintomas"],
        diagnostico: json["diagnostico"],
      );
}
