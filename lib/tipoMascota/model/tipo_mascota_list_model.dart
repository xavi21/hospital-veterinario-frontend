class TipoMascotaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idTipoMascota;
  final String nombre;

  TipoMascotaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idTipoMascota,
    required this.nombre,
  });

  factory TipoMascotaListModel.fromJson(Map<String, dynamic> json) =>
      TipoMascotaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idTipoMascota: json["idTipoMascota"],
        nombre: json["nombre"],
      );
}
