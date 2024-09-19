class RecetaListModel {
  final String medicamento;
  final String indicaciones;
  final int cantidad;
  final int idreceta;
  bool isHover;

  RecetaListModel({
    required this.medicamento,
    required this.indicaciones,
    required this.cantidad,
    required this.idreceta,
    this.isHover = false,
  });

  factory RecetaListModel.fromJson(Map<String, dynamic> json) =>
      RecetaListModel(
        medicamento: json["medicamento"],
        indicaciones: json["indicaciones"],
        cantidad: json["cantidad"],
        idreceta: json["idreceta"],
      );

  Map<String, dynamic> toJson() => {
        "medicamento": medicamento,
        "indicaciones": indicaciones,
        "cantidad": cantidad,
        "idreceta": idreceta,
      };
}
