import 'dart:convert';

class LoginResponse {
  String idusuario;
  DateTime ultimafechaingreso;
  int intentosdeacceso;
  dynamic sesionactual;
  DateTime ultimafechacambiopassword;
  dynamic telefonomovil;
  int idstatususuario;
  int idsucursal;
  String accessToken;
  String tokenType;

  LoginResponse({
    required this.idusuario,
    required this.ultimafechaingreso,
    required this.intentosdeacceso,
    required this.sesionactual,
    required this.ultimafechacambiopassword,
    required this.telefonomovil,
    required this.idstatususuario,
    required this.idsucursal,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        idusuario: json["idusuario"],
        ultimafechaingreso: DateTime.parse(json["ultimafechaingreso"]),
        intentosdeacceso: json["intentosdeacceso"],
        sesionactual: json["sesionactual"],
        ultimafechacambiopassword:
            DateTime.parse(json["ultimafechacambiopassword"]),
        telefonomovil: json["telefonomovil"],
        idstatususuario: json["idstatususuario"],
        idsucursal: json["idsucursal"],
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
      );

  Map<String, dynamic> toJson() => {
        "idusuario": idusuario,
        "ultimafechaingreso":
            "${ultimafechaingreso.year.toString().padLeft(4, '0')}-${ultimafechaingreso.month.toString().padLeft(2, '0')}-${ultimafechaingreso.day.toString().padLeft(2, '0')}",
        "intentosdeacceso": intentosdeacceso,
        "sesionactual": sesionactual,
        "ultimafechacambiopassword":
            "${ultimafechacambiopassword.year.toString().padLeft(4, '0')}-${ultimafechacambiopassword.month.toString().padLeft(2, '0')}-${ultimafechacambiopassword.day.toString().padLeft(2, '0')}",
        "telefonomovil": telefonomovil,
        "idstatususuario": idstatususuario,
        "idsucursal": idsucursal,
        "accessToken": accessToken,
        "tokenType": tokenType,
      };
}
