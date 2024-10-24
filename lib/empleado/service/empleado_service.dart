import 'package:dio/dio.dart';
import 'package:paraiso_canino/empleado/model/empleado_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class EmpleadoService {
  Dio client;

  EmpleadoService() : client = ClientFactory.buildClient();

  EmpleadoService.withClient(
    this.client,
  );

  Future<List<EmpleadoListModel>> getEmpleados() async {
    final response = await client.get(
      getEmpleadosPath,
    );
    return List<EmpleadoListModel>.from(
      response.data['data'].map(
        (empelado) => EmpleadoListModel.fromJson(empelado),
      ),
    );
  }

  Future<Response<dynamic>> createEmpleado({
    required String name,
    required String lastName,
    required String birthDate,
    required String contractDate,
    required int idSucursal,
    required int idPuesto,
    required int idEstadoCivil,
    required int idGenero,
    required int idStatusEmpleado,
  }) async {
    return await client.post(
      createEmpleadoPath,
      data: {
        "nombre": name,
        "apellido": lastName,
        "fechanacimiento": birthDate,
        "fechacontratacion": contractDate,
        "idsucursal": idSucursal,
        "idpuesto": idPuesto,
        "idestadocivil": idEstadoCivil,
        "idgenero": idGenero,
        "idstatusempleado": idStatusEmpleado,
      },
    );
  }

  Future<Response<dynamic>> updateEmpleado({
    required int id,
    required String name,
    required String lastName,
    required String birthDate,
    required String contractDate,
    required int idSucursal,
    required int idPuesto,
    required int idEstadoCivil,
    required int idGenero,
    required int idStatusEmpleado,
  }) async {
    return await client.put(
      updateEmpleadoPath,
      data: {
        "idempleado": id,
        "nombre": name,
        "apellido": lastName,
        "fechanacimiento": birthDate,
        "fechacontratacion": contractDate,
        "idsucursal": idSucursal,
        "idpuesto": idPuesto,
        "idestadocivil": idEstadoCivil,
        "idgenero": idGenero,
        "idstatusempleado": idStatusEmpleado,
      },
    );
  }

  Future<Response<dynamic>> deleteEmpleado({
    required int id,
  }) async {
    return await client.delete(
      deleteEmpleadoPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
