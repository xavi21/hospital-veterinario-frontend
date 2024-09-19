class EmpleadoListModel {
  final String nombre;
  final String apellido;
  final int idpuesto;

  EmpleadoListModel({
    required this.nombre,
    required this.apellido,
    required this.idpuesto,
  });

  factory EmpleadoListModel.fromJson(Map<String, dynamic> json) =>
      EmpleadoListModel(
        nombre: json["nombre"],
        apellido: json["apellido"],
        idpuesto: json["idpuesto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "idpuesto": idpuesto,
      };
}
