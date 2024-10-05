class LabHospitalListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final int idlaboratorio;
  final String nombre;
  final String descripcion;
  final String resultado;
  final String fechasolicitud;
  final String fecharesultado;
  final int idhospitalizacion;
  final int idhospitalizacionlaboratorio;
  bool isHover;

  LabHospitalListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.idlaboratorio,
    required this.nombre,
    required this.descripcion,
    required this.resultado,
    required this.fechasolicitud,
    required this.fecharesultado,
    required this.idhospitalizacion,
    required this.idhospitalizacionlaboratorio,
    this.isHover = false,
  });

  factory LabHospitalListModel.fromJson(Map<String, dynamic> json) =>
      LabHospitalListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        idlaboratorio: json["idlaboratorio"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        resultado: json["resultado"],
        fechasolicitud: json["fechasolicitud"],
        fecharesultado: json["fecharesultado"],
        idhospitalizacion: json["idhospitalizacion"],
        idhospitalizacionlaboratorio: json["idhospitalizacionlaboratorio"],
      );
}
