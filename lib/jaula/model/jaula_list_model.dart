class JaulaListModel {
  final String fechacreacion;
  final String usuariocreacion;
  final String fechamodificacion;
  final String usuariomodificacion;
  final int idJaula;
  final String descripcion;
  bool isHover;

  JaulaListModel({
    required this.fechacreacion,
    required this.usuariocreacion,
    required this.fechamodificacion,
    required this.usuariomodificacion,
    required this.idJaula,
    required this.descripcion,
    this.isHover = false,
  });

  factory JaulaListModel.fromJson(Map<String, dynamic> json) => JaulaListModel(
        fechacreacion: json['fechacreacion'],
        usuariocreacion: json['usuariocreacion'],
        fechamodificacion: json['fechamodificacion'],
        usuariomodificacion: json['usuariomodificacion'],
        idJaula: json['idJaula'],
        descripcion: json['descripcion'],
      );
}
