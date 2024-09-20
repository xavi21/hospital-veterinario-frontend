class AmbulanciaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idAmbulancia;
  final String placa;
  final String marca;
  final String modelo;
  final String latitud;
  final String longitud;
  final int idEmpleado;
  bool isHover;

  AmbulanciaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idAmbulancia,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.latitud,
    required this.longitud,
    required this.idEmpleado,
    this.isHover = false,
  });

  factory AmbulanciaListModel.fromJson(Map<String, dynamic> json) =>
      AmbulanciaListModel(
        fechacreacion: json["fechacreacion"],
        usuariocreacion: json["usuariocreacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idAmbulancia: json["idAmbulancia"],
        placa: json["placa"],
        marca: json["marca"],
        modelo: json["modelo"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        idEmpleado: json["idEmpleado"],
      );
}
