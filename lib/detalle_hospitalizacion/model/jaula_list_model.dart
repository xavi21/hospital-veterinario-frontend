class JaulaModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idJaula;
  final String descripcion;

  JaulaModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idJaula,
    required this.descripcion,
  });

  factory JaulaModel.fromJson(Map<String, dynamic> json) => JaulaModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idJaula: json["idJaula"],
        descripcion: json["descripcion"],
      );
}
