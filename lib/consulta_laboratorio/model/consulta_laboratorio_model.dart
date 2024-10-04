class ConsultaLaboratorioModel {
  final int idconsultalaboratorio;
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final int idlaboratorio;
  final String nombre;
  final String descripcion;
  final String resultado;
  final String fechasolicitud;
  final int idconsulta;
  final String fecharesultado;
  bool isHover;

  ConsultaLaboratorioModel({
    required this.idconsultalaboratorio,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.idlaboratorio,
    required this.nombre,
    required this.descripcion,
    required this.resultado,
    required this.fechasolicitud,
    required this.idconsulta,
    required this.fecharesultado,
    this.isHover = false,
  });

  factory ConsultaLaboratorioModel.fromJson(Map<String, dynamic> json) =>
      ConsultaLaboratorioModel(
        idconsultalaboratorio: json["idconsultalaboratorio"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        idlaboratorio: json["idlaboratorio"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        resultado: json["resultado"],
        fechasolicitud: json["fechasolicitud"],
        idconsulta: json["idconsulta"],
        fecharesultado: json["fecharesultado"],
      );
}
