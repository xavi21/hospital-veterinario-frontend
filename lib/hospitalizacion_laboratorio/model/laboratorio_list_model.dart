import 'package:paraiso_canino/resources/constants.dart';

class LaboratorioListModel {
  final String fechaSolicitud;
  final String fechaResultado;
  final int idLaboratorio;
  final String nombre;
  final String descripcion;
  bool isHover;

  LaboratorioListModel({
    required this.fechaSolicitud,
    required this.fechaResultado,
    required this.idLaboratorio,
    required this.nombre,
    required this.descripcion,
    this.isHover = false,
  });

  factory LaboratorioListModel.fromJson(Map<String, dynamic> json) =>
      LaboratorioListModel(
        fechaSolicitud: json["fechaSolicitud"] ?? emptyString,
        fechaResultado: json["fechaResultado"] ?? emptyString,
        idLaboratorio: json["idLaboratorio"],
        nombre: json["nombre"] ?? emptyString,
        descripcion: json["descripcion"] ?? emptyString,
      );
}
