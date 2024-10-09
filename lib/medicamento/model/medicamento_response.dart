class MedicamentoListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final String nombre;
  final String descripcion;
  final int idmedicamento;
  final String nombreCasaMedica;
  final String nombrecomercial;
  final String nombreComponentePrincipal;
  final int idcasamedica;
  final int idcomponenteprincipal;
  bool isHover;

  MedicamentoListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.nombre,
    required this.descripcion,
    required this.idmedicamento,
    required this.nombreCasaMedica,
    required this.nombrecomercial,
    required this.nombreComponentePrincipal,
    required this.idcasamedica,
    required this.idcomponenteprincipal,
    this.isHover = false,
  });

  factory MedicamentoListModel.fromJson(Map<String, dynamic> json) =>
      MedicamentoListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idmedicamento: json["idmedicamento"],
        nombreCasaMedica: json["nombre_casa_medica"],
        nombrecomercial: json["nombrecomercial"],
        nombreComponentePrincipal: json["nombre_componente_principal"],
        idcasamedica: json["idcasamedica"],
        idcomponenteprincipal: json["idcomponenteprincipal"],
      );
}
