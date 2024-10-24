class CasaMedicaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idcasamedica;
  final String nombre;
  final String nombrecomercial;

  CasaMedicaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idcasamedica,
    required this.nombre,
    required this.nombrecomercial,
  });

  factory CasaMedicaListModel.fromJson(Map<String, dynamic> json) =>
      CasaMedicaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idcasamedica: json["idcasamedica"],
        nombre: json["nombre"],
        nombrecomercial: json["nombrecomercial"],
      );
}
