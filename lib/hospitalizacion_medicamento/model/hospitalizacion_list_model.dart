class HospitalizacionListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final String nombre;
  final int idmedicamento;
  final String nombreCasaMedica;
  final String nombrecomercial;
  final String nombreComponentePrincipal;
  final String observaciones;
  final int idhospitalizacion;
  final int idhospitalizacionmedicamento;
  bool isHover;

  HospitalizacionListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.nombre,
    required this.idmedicamento,
    required this.nombreCasaMedica,
    required this.nombrecomercial,
    required this.nombreComponentePrincipal,
    required this.observaciones,
    required this.idhospitalizacion,
    required this.idhospitalizacionmedicamento,
    this.isHover = false,
  });

  factory HospitalizacionListModel.fromJson(Map<String, dynamic> json) =>
      HospitalizacionListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        nombre: json["nombre"],
        idmedicamento: json["idmedicamento"],
        nombreCasaMedica: json["nombre_casa_medica"],
        nombrecomercial: json["nombrecomercial"],
        nombreComponentePrincipal: json["nombre_componente_principal"],
        observaciones: json["observaciones"],
        idhospitalizacion: json["idhospitalizacion"],
        idhospitalizacionmedicamento: json["idhospitalizacionmedicamento"],
      );
}
