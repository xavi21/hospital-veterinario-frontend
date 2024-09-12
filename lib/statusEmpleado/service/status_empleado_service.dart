import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/statusEmpleado/model/status_empleado_response.dart';

class StatusEmpleadoService {
  Dio client;

  StatusEmpleadoService() : client = ClientFactory.buildClient();

  StatusEmpleadoService.withClient(
    this.client,
  );

  Future<List<StatusEmpleadoListModel>> getStatusEmpleados() async {
    final response = await client.get(
      getStatusEmpleadosPath,
    );
    return List<StatusEmpleadoListModel>.from(
      response.data['data'].map(
        (sucursal) => StatusEmpleadoListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createStatusEmpleado({
    required String name,
  }) async {
    return await client.post(
      createStatusEmpleadoPath,
      data: {
        'name': name,
      },
    );
  }

  Future<Response<dynamic>> updateStatusEmpleado({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateStatusEmpleadoPath,
      data: {
        'idstatusempleado': id,
        'name': name,
      },
    );
  }

  Future<Response<dynamic>> deleteStatusEmpleado({
    required int id,
  }) async {
    return await client.delete(
      deleteStatusEmpleadoPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
