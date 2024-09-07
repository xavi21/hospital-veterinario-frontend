class MascotaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idTipoMascota;
  final String nombre;
  bool isHover;

  MascotaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idTipoMascota,
    required this.nombre,
    this.isHover = false,
  });

  factory MascotaListModel.fromJson(Map<String, dynamic> json) =>
      MascotaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idTipoMascota: json["idTipoMascota"],
        nombre: json["nombre"],
      );
}
