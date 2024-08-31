import 'package:paraiso_canino/resources/constants.dart';

class MenuListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idmenu;
  final String name;
  final int ordenmenu;

  MenuListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idmenu,
    required this.name,
    required this.ordenmenu,
  });

  factory MenuListModel.fromJson(Map<String, dynamic> json) => MenuListModel(
        fechacreacion: json["fechacreacion"] ?? emptyString,
        usuariocreacion: json["usuariocreacion"] ?? emptyString,
        fechamodificacion: json["fechamodificacion"] ?? emptyString,
        usuariomodificacion: json["usuariomodificacion"] ?? emptyString,
        idmenu: json["idmenu"] ?? 0,
        name: json["name"] ?? emptyString,
        ordenmenu: json["ordenmenu"] ?? 0,
      );
}
