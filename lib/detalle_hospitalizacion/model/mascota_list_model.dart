class MascotaModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final int idmascota;
  final String nombreMascota;
  final String nombreGenero;
  final String fechamodificacion;
  final String apellidoPropietario;
  final String nombreTipoMascota;
  final String nombreTalla;
  final String nombreColor;
  final int peso;
  final String nombrePropietario;
  final int idColor;
  final int idTalla;
  final int idTipoMascota;
  final int idGenero;
  final int idpersona;

  MascotaModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.idmascota,
    required this.nombreMascota,
    required this.nombreGenero,
    required this.fechamodificacion,
    required this.apellidoPropietario,
    required this.nombreTipoMascota,
    required this.nombreTalla,
    required this.nombreColor,
    required this.peso,
    required this.nombrePropietario,
    required this.idColor,
    required this.idTalla,
    required this.idTipoMascota,
    required this.idGenero,
    required this.idpersona,
  });

  factory MascotaModel.fromJson(Map<String, dynamic> json) => MascotaModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        idmascota: json["idmascota"],
        nombreMascota: json["nombre_mascota"],
        nombreGenero: json["nombre_genero"],
        fechamodificacion: json["fechamodificacion"],
        apellidoPropietario: json["apellido_propietario"],
        nombreTipoMascota: json["nombre_tipo_mascota"],
        nombreTalla: json["nombre_talla"],
        nombreColor: json["nombre_color"],
        peso: json["peso"],
        nombrePropietario: json["nombre_propietario"],
        idColor: json["id_color"],
        idTalla: json["id_talla"],
        idTipoMascota: json["id_tipo_mascota"],
        idGenero: json["id_genero"],
        idpersona: json["idpersona"],
      );
}
