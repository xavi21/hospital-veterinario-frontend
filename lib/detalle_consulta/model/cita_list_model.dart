class CitaListModel {
  final int idestatuscita;
  final String nombre;
  bool isHover;

  CitaListModel({
    required this.idestatuscita,
    required this.nombre,
    this.isHover = false,
  });

  factory CitaListModel.fromJson(Map<String, dynamic> json) => CitaListModel(
        idestatuscita: json["idestatuscita"],
        nombre: json["nombre"],
      );
}
