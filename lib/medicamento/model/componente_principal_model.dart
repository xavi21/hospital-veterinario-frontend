class ComponentePrincipalListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idComponentePrincipal;
  final String nombre;

  ComponentePrincipalListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idComponentePrincipal,
    required this.nombre,
  });

  factory ComponentePrincipalListModel.fromJson(Map<String, dynamic> json) =>
      ComponentePrincipalListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idComponentePrincipal: json["idComponentePrincipal"],
        nombre: json["nombre"],
      );
}
