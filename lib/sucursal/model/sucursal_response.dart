import 'package:paraiso_canino/resources/constants.dart';

class OfficeListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idsucursal;
  final String name;
  final String direccion;
  final String usuario;
  bool isHover;

  OfficeListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idsucursal,
    required this.name,
    required this.direccion,
    required this.usuario,
    this.isHover = false,
  });

  factory OfficeListModel.fromJson(Map<String, dynamic> json) =>
      OfficeListModel(
        fechacreacion: json["fechacreacion"] ?? emptyString,
        usuariocreacion: json["usuariocreacion"] ?? emptyString,
        fechamodificacion: json["fechamodificacion"] ?? emptyString,
        usuariomodificacion: json["usuariomodificacion"] ?? emptyString,
        idsucursal: json["idsucursal"] ?? emptyString,
        name: json["name"] ?? emptyString,
        direccion: json["direccion"] ?? emptyString,
        usuario: json["usuario"] ?? emptyString,
      );
}
