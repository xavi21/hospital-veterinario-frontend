class StatusEmpleadoListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final String name;
  final int idStatusEmpleado;
  bool isHover;

  StatusEmpleadoListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.name,
    required this.idStatusEmpleado,
    this.isHover = false,
  });

  factory StatusEmpleadoListModel.fromJson(Map<String, dynamic> json) =>
      StatusEmpleadoListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        name: json["name"],
        idStatusEmpleado: json["idStatusEmpleado"],
      );
}
