class MascotaListModel {
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idmascota;
  final String nombreMascota;
  final String usuariocreacion;
  final String fechacreacion;
  final String nombrePropietario;
  final String apellidoPropietario;
  final String nombreTipoMascota;
  final String nombreColor;
  final int peso;
  final String nombreTalla;
  final String nombreGenero;
  final int idColor;
  final int idTalla;
  final int idTipoMascota;
  final int idGenero;
  final int idpersona;
  bool isHover;

  MascotaListModel({
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idmascota,
    required this.nombreMascota,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.nombrePropietario,
    required this.apellidoPropietario,
    required this.nombreTipoMascota,
    required this.nombreColor,
    required this.peso,
    required this.nombreTalla,
    required this.nombreGenero,
    required this.idColor,
    required this.idTalla,
    required this.idTipoMascota,
    required this.idGenero,
    required this.idpersona,
    this.isHover = false,
  });

  factory MascotaListModel.fromJson(Map<String, dynamic> json) =>
      MascotaListModel(
        fechamodificacion: json["fechamodificacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idmascota: json["idmascota"],
        nombreMascota: json["nombre_mascota"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        nombrePropietario: json["nombre_propietario"],
        apellidoPropietario: json["apellido_propietario"],
        nombreTipoMascota: json["nombre_tipo_mascota"],
        nombreColor: json["nombre_color"],
        peso: json["peso"],
        nombreTalla: json["nombre_talla"],
        nombreGenero: json["nombre_genero"],
        idColor: json["id_color"],
        idTalla: json["id_talla"],
        idTipoMascota: json["id_tipo_mascota"],
        idGenero: json["id_genero"],
        idpersona: json["idpersona"],
      );
}
