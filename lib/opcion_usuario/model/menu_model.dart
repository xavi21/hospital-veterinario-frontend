class MenuModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idmenu;
  final String name;
  final int ordenmenu;
  bool isHover;

  MenuModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idmenu,
    required this.name,
    required this.ordenmenu,
    this.isHover = false,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idmenu: json["idmenu"],
        name: json["name"],
        ordenmenu: json["ordenmenu"],
      );
}
