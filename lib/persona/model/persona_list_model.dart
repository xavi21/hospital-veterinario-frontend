class PersonaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idPersona;
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final int idGenero;
  final String direccion;
  final String telefono;
  final String correoElectronico;
  final int idEstadoCivil;
  bool isHover;

  PersonaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idPersona,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.idGenero,
    required this.direccion,
    required this.telefono,
    required this.correoElectronico,
    required this.idEstadoCivil,
    this.isHover = false,
  });

  factory PersonaListModel.fromJson(Map<String, dynamic> json) =>
      PersonaListModel(
        fechacreacion: json['fechacreacion'],
        usuariocreacion: json['usuariocreacion'],
        fechamodificacion: json['fechamodificacion'],
        usuariomodificacion: json['usuariomodificacion'],
        idPersona: json['idPersona'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        fechaNacimiento: json['fechaNacimiento'],
        idGenero: json['idGenero'],
        direccion: json['direccion'],
        telefono: json['telefono'],
        correoElectronico: json['correoElectronico'],
        idEstadoCivil: json['idEstadoCivil'],
      );
}
