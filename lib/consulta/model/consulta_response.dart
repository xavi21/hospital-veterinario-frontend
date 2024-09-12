class ConsultaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idConsulta;
  final String nombre;
  bool isHover;

  ConsultaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idConsulta,
    required this.nombre,
    this.isHover = false,
  });

  factory ConsultaListModel.fromJson(Map<String, dynamic> json) =>
      ConsultaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idConsulta: json["idConsulta"],
        nombre: json["nombre"],
      );
}
