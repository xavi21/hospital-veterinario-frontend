class StatusCitaListModel {
  final DateTime fechacreacion;
  final String usuariocreacion;
  final DateTime fechamodificacion;
  final String usuariomodificacion;
  final int idestatuscita;
  final String nombre;

  StatusCitaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idestatuscita,
    required this.nombre,
  });

  factory StatusCitaListModel.fromJson(Map<String, dynamic> json) =>
      StatusCitaListModel(
        fechacreacion: DateTime.parse(json["fechacreacion"]),
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: DateTime.parse(json["fechamodificacion"]),
        usuariomodificacion: json["usuariomodificacion"],
        idestatuscita: json["idestatuscita"],
        nombre: json["nombre"],
      );
}
