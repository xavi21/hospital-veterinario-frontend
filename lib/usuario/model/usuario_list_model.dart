class UsuarioListModel {
  final int idstatususuario;
  final String statusUsuario;
  final int intentosdeacceso;
  final String password;
  final dynamic sesionactual;
  final dynamic telefonomovil;
  final String ultimafechacambiopassword;
  final String ultimafechaingreso;
  final String sucursal;
  final dynamic usuariocreacion;
  final dynamic fechacreacion;
  final dynamic usuariomodificacion;
  final dynamic fechamodificacion;
  final String idusuario;
  final int idsucursal;
  bool isHover;

  UsuarioListModel({
    required this.idstatususuario,
    required this.statusUsuario,
    required this.intentosdeacceso,
    required this.password,
    required this.sesionactual,
    required this.telefonomovil,
    required this.ultimafechacambiopassword,
    required this.ultimafechaingreso,
    required this.sucursal,
    required this.usuariocreacion,
    required this.fechacreacion,
    required this.usuariomodificacion,
    required this.fechamodificacion,
    required this.idusuario,
    required this.idsucursal,
    this.isHover = false,
  });

  factory UsuarioListModel.fromJson(Map<String, dynamic> json) =>
      UsuarioListModel(
        idstatususuario: json["idstatususuario"],
        statusUsuario: json["status_usuario"],
        intentosdeacceso: json["intentosdeacceso"],
        password: json["password"],
        sesionactual: json["sesionactual"],
        telefonomovil: json["telefonomovil"],
        ultimafechacambiopassword: json["ultimafechacambiopassword"],
        ultimafechaingreso: json["ultimafechaingreso"],
        sucursal: json["sucursal"],
        usuariocreacion: json["usuariocreacion"],
        fechacreacion: json["fechacreacion"],
        usuariomodificacion: json["usuariomodificacion"],
        fechamodificacion: json["fechamodificacion"],
        idusuario: json["idusuario"],
        idsucursal: json["idsucursal"],
      );
}
