class TallaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idTalla;
  final String nombre;
  bool isHover;

  TallaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idTalla,
    required this.nombre,
    this.isHover = false,
  });

  factory TallaListModel.fromJson(Map<String, dynamic> json) => TallaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idTalla: json["idTalla"],
        nombre: json["nombre"],
      );
}
