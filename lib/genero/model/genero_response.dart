class GeneroListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idGenero;
  final String nombre;
  bool isHover;

  GeneroListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idGenero,
    required this.nombre,
    this.isHover = false,
  });

  factory GeneroListModel.fromJson(Map<String, dynamic> json) =>
      GeneroListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idGenero: json["id_genero"],
        nombre: json["nombre"],
      );
}
