class HospitalizacionListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final int idmascota;
  final String nombreMascota;
  final String motivo;
  final String nombreGenero;
  final String fechamodificacion;
  final String apellidoPropietario;
  final String nombreTipoMascota;
  final int idjaula;
  final String fechaingreso;
  final String descripcion;
  final String fechasalida;
  final String observaciones;
  final String nombreTalla;
  final String nombreColor;
  final int peso;
  final String nombrePropietario;
  final int idhospitalizacion;
  bool isHover;

  HospitalizacionListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.idmascota,
    required this.nombreMascota,
    required this.motivo,
    required this.nombreGenero,
    required this.fechamodificacion,
    required this.apellidoPropietario,
    required this.nombreTipoMascota,
    required this.idjaula,
    required this.fechaingreso,
    required this.descripcion,
    required this.fechasalida,
    required this.observaciones,
    required this.nombreTalla,
    required this.nombreColor,
    required this.peso,
    required this.nombrePropietario,
    required this.idhospitalizacion,
    this.isHover = false,
  });

  factory HospitalizacionListModel.fromJson(Map<String, dynamic> json) =>
      HospitalizacionListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idmascota: json["idmascota"],
        nombreMascota: json["nombre_mascota"],
        motivo: json["motivo"],
        nombreGenero: json["nombre_genero"],
        fechamodificacion: json["fechamodificacion"],
        apellidoPropietario: json["apellido_propietario"],
        nombreTipoMascota: json["nombre_tipo_mascota"],
        idjaula: json["idjaula"],
        fechaingreso: json["fechaingreso"],
        descripcion: json["descripcion"],
        fechasalida: json["fechasalida"],
        observaciones: json["observaciones"],
        nombreTalla: json["nombre_talla"],
        nombreColor: json["nombre_color"],
        peso: json["peso"],
        nombrePropietario: json["nombre_propietario"],
        idhospitalizacion: json["idhospitalizacion"],
      );
}
