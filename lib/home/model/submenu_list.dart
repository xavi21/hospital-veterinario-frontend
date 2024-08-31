import 'package:paraiso_canino/resources/constants.dart';

class SubMenuListModel {
  final String idusuario;
  final String menuNombre;
  final int idmenu;
  final int idopcion;
  final String opcionNombre;
  final int alta;
  final int baja;
  final int cambio;

  SubMenuListModel({
    required this.idusuario,
    required this.menuNombre,
    required this.idmenu,
    required this.idopcion,
    required this.opcionNombre,
    required this.alta,
    required this.baja,
    required this.cambio,
  });

  factory SubMenuListModel.fromJson(Map<String, dynamic> json) =>
      SubMenuListModel(
        idusuario: json["idusuario"] ?? emptyString,
        menuNombre: json["menu_nombre"] ?? emptyString,
        idmenu: json["idmenu"] ?? 0,
        idopcion: json["idopcion"] ?? 0,
        opcionNombre: json["opcion_nombre"] ?? emptyString,
        alta: json["alta"] ?? 0,
        baja: json["baja"] ?? 0,
        cambio: json["cambio"] ?? 0,
      );
}
