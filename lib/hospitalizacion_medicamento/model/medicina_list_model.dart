class MedicinaListModel {
  final String usuariomodificacion;
  final String fechamodificacion;
  final String usuariocreacion;
  final String fechacreacion;
  final int idmedicamento;
  final String nombreCasaMedica;
  final String nombrecomercial;
  final String nombreComponentePrincipal;
  final String nombre;
  final String descripcion;
  final int idcasamedica;
  final int idcomponenteprincipal;

  MedicinaListModel({
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.idmedicamento,
    required this.nombreCasaMedica,
    required this.nombrecomercial,
    required this.nombreComponentePrincipal,
    required this.nombre,
    required this.descripcion,
    required this.idcasamedica,
    required this.idcomponenteprincipal,
  });

  factory MedicinaListModel.fromJson(Map<String, dynamic> json) =>
      MedicinaListModel(
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        idmedicamento: json["idmedicamento"],
        nombreCasaMedica: json["nombre_casa_medica"],
        nombrecomercial: json["nombrecomercial"],
        nombreComponentePrincipal: json["nombre_componente_principal"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idcasamedica: json["idcasamedica"],
        idcomponenteprincipal: json["idcomponenteprincipal"],
      );
}
