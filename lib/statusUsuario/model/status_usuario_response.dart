import 'package:paraiso_canino/resources/constants.dart';

class StatusUsuarioListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idstatususuario;
  final String name;
  bool isHover;

  StatusUsuarioListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idstatususuario,
    required this.name,
    this.isHover = false,
  });

  factory StatusUsuarioListModel.fromJson(Map<String, dynamic> json) =>
      StatusUsuarioListModel(
        fechacreacion: json["fechacreacion"] ?? emptyString,
        usuariocreacion: json["usuariocreacion"] ?? emptyString,
        fechamodificacion: json["fechamodificacion"] ?? emptyString,
        usuariomodificacion: json["usuariomodificacion"] ?? emptyString,
        idstatususuario: json["idstatususuario"] ?? emptyString,
        name: json["name"] ?? emptyString,
      );
}
