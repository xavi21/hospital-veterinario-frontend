import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/grooming/model/cita_list_model.dart';
import 'package:paraiso_canino/grooming/model/empleado_list_model.dart';
import 'package:paraiso_canino/grooming/model/grooming_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class GroomingService {
  Dio client;

  GroomingService() : client = ClientFactory.buildClient();

  GroomingService.withClient(
    this.client,
  );

  Future<List<CitaModel>> getCitas() async {
    final response = await client.get(
      getCitasPath,
    );
    return List<CitaModel>.from(
      response.data['data'].map(
        (cita) => CitaModel.fromJson(cita),
      ),
    );
  }

  Future<List<EmpleadoModel>> getEmpleados() async {
    final response = await client.get(
      getEmpleadosPath,
    );
    return List<EmpleadoModel>.from(
      response.data['data'].map(
        (empleado) => EmpleadoModel.fromJson(empleado),
      ),
    );
  }

  Future<List<GroomingListModel>> getGrooming() async {
    final response = await client.get(
      getGroomingsPath,
    );
    return List<GroomingListModel>.from(
      response.data['data'].map(
        (grooming) => GroomingListModel.fromJson(grooming),
      ),
    );
  }

  Future<Response<dynamic>> createGrooming({
    required int idCita,
    required int idEmpleado,
  }) async {
    return await client.post(
      createGroomingPath,
      data: {
        "idcita": idCita,
        "idempleado": idEmpleado,
      },
    );
  }

  Future<Response<dynamic>> updateGrooming({
    required int idGrooming,
    required int idCita,
    required int idEmpleado,
  }) async {
    return await client.put(
      updateGroomingPath,
      data: {
        "fechacreacion": "2024-09-24",
        "usuariocreacion": "jsalazar",
        "fechamodificacion": "2024-09-24",
        "usuariomodificacion": "jsalazar",
        "idgrooming": idGrooming,
        "idcita": idCita,
        "idempleado": idEmpleado,
      },
    );
  }
}
