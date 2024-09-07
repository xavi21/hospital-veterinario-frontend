class ColorListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idColor;
  final String nombre;
  bool isHover;

  ColorListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idColor,
    required this.nombre,
    this.isHover = false,
  });

  factory ColorListModel.fromJson(Map<String, dynamic> json) => ColorListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idColor: json["idColor"],
        nombre: json["nombre"],
      );
}
