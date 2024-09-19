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
        fechaSolicitud: json["fechaSolicitud"],
        fechaResultado: json["fechaResultado"],
        idLaboratorio: json["idLaboratorio"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
      );
}
