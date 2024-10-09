class UsuarioListModel {
  final String usuariocreacion;
  final String fechacreacion;
  final String usuariomodificacion;
  final String fechamodificacion;
  final String nombre;
  final String descripcion;
  final int idusuario;
  bool isHover;

  UsuarioListModel({
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.nombre,
    required this.descripcion,
    required this.idusuario,
    this.isHover = false,
  });

  factory UsuarioListModel.fromJson(Map<String, dynamic> json) =>
      UsuarioListModel(
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        idusuario: json["idusuario"],
      );
}
