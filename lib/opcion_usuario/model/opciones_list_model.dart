import 'package:paraiso_canino/resources/constants.dart';

class OpcionesListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idopcion;
  final String name;
  final int ordenmenu;
  final String pagina;
  bool isHover;

  OpcionesListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idopcion,
    required this.name,
    required this.ordenmenu,
    required this.pagina,
    this.isHover = false,
  });

  factory OpcionesListModel.fromJson(Map<String, dynamic> json) =>
      OpcionesListModel(
        fechacreacion: json["fechacreacion"] ?? emptyString,
        usuariocreacion: json["usuariocreacion"] ?? emptyString,
        fechamodificacion: json["fechamodificacion"] ?? emptyString,
        usuariomodificacion: json["usuariomodificacion"] ?? emptyString,
        idopcion: json["idopcion"] ?? 0,
        name: json["name"] ?? emptyString,
        ordenmenu: json["ordenmenu"] ?? 0,
        pagina: json["pagina"] ?? emptyString,
      );
}
