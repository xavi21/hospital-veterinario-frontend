class CitaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idestatuscita;
  final String nombre;
  bool isHover;

  CitaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idestatuscita,
    required this.nombre,
    this.isHover = false,
  });

  factory CitaListModel.fromJson(Map<String, dynamic> json) => CitaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idestatuscita: json["idestatuscita"],
        nombre: json["nombre"],
      );
}
