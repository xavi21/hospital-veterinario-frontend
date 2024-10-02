class RecetaListModel {
  final String usuariomodificacion;
  final String fechamodificacion;
  final String usuariocreacion;
  final String fechacreacion;
  final int idreceta;
  final int idmedicamento;
  final String nombreMedicamento;
  final String nombreCasaMedica;
  final String nombrecomercial;
  final String nombreComponentePrincipal;
  final int cantidad;
  final String indicaciones;
  bool isHover;

  RecetaListModel({
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.idreceta,
    required this.idmedicamento,
    required this.nombreMedicamento,
    required this.nombreCasaMedica,
    required this.nombrecomercial,
    required this.nombreComponentePrincipal,
    required this.cantidad,
    required this.indicaciones,
    this.isHover = false,
  });

  factory RecetaListModel.fromJson(Map<String, dynamic> json) =>
      RecetaListModel(
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        idreceta: json["idreceta"],
        idmedicamento: json["idmedicamento"],
        nombreMedicamento: json["nombre_medicamento"],
        nombreCasaMedica: json["nombre_casa_medica"],
        nombrecomercial: json["nombrecomercial"],
        nombreComponentePrincipal: json["nombre_componente_principal"],
        cantidad: json["cantidad"],
        indicaciones: json["indicaciones"],
      );
}
