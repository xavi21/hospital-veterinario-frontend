class MascotaListModel {
  final String usuariomodificacion;
  final String fechamodificacion;
  final int idmascota;
  final String nombreMascota;
  final String usuariocreacion;
  final String fechacreacion;
  final String nombreTipoMascota;
  final int idGenero;
  final int idpersona;
  final String nombrePropietario;
  final String apellidoPropietario;
  final String nombreGenero;
  final int peso;
  final int idColor;
  final String nombreColor;
  final int idTalla;
  final String nombreTalla;
  final int idTipoMascota;

  MascotaListModel({
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.idmascota,
    required this.nombreMascota,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.nombreTipoMascota,
    required this.idGenero,
    required this.idpersona,
    required this.nombrePropietario,
    required this.apellidoPropietario,
    required this.nombreGenero,
    required this.peso,
    required this.idColor,
    required this.nombreColor,
    required this.idTalla,
    required this.nombreTalla,
    required this.idTipoMascota,
  });

  factory MascotaListModel.fromJson(Map<String, dynamic> json) =>
      MascotaListModel(
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        idmascota: json["idmascota"],
        nombreMascota: json["nombre_mascota"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        nombreTipoMascota: json["nombre_tipo_mascota"],
        idGenero: json["id_genero"],
        idpersona: json["idpersona"],
        nombrePropietario: json["nombre_propietario"],
        apellidoPropietario: json["apellido_propietario"],
        nombreGenero: json["nombre_genero"],
        peso: json["peso"],
        idColor: json["id_color"],
        nombreColor: json["nombre_color"],
        idTalla: json["id_talla"],
        nombreTalla: json["nombre_talla"],
        idTipoMascota: json["id_tipo_mascota"],
      );
}
