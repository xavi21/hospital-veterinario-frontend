import 'package:paraiso_canino/resources/constants.dart';

class LaboratorioListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idLaboratorio;
  final String nombre;
  final String descripcion;
  bool isHover;

  LaboratorioListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idLaboratorio,
    required this.nombre,
    required this.descripcion,
    this.isHover = false,
  });

  factory LaboratorioListModel.fromJson(Map<String, dynamic> json) =>
      LaboratorioListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idLaboratorio: json["idLaboratorio"],
        nombre: json["nombre"],
        descripcion: json["descripcion"] ?? emptyString,
      );
}
