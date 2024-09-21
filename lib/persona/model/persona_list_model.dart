class PersonaListModel {
  final String usuariomodificacion;
  final String fechamodificacion;
  final String usuariocreacion;
  final String fechacreacion;
  final String fechanacimiento;
  final String nombreEstadoCivil;
  final int idGenero;
  final int idpersona;
  final String nombreGenero;
  final String nombre;
  final String apellido;
  final String telefono;
  final String direccion;
  final String correoelectronico;
  final int idEstadoCivil;
  bool isHover;

  PersonaListModel({
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.fechanacimiento,
    required this.nombreEstadoCivil,
    required this.idGenero,
    required this.idpersona,
    required this.nombreGenero,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.direccion,
    required this.correoelectronico,
    required this.idEstadoCivil,
    this.isHover = false,
  });

  factory PersonaListModel.fromJson(Map<String, dynamic> json) =>
      PersonaListModel(
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        fechanacimiento: json["fechanacimiento"],
        nombreEstadoCivil: json["nombre_estado_civil"],
        idGenero: json["id_genero"],
        idpersona: json["idpersona"],
        nombreGenero: json["nombre_genero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        correoelectronico: json["correoelectronico"],
        idEstadoCivil: json["id_estado_civil"],
      );
}
