import 'package:dio/dio.dart';
import 'package:paraiso_canino/detalle_consulta/model/cita_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/model/empleado_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class DetalleConsultaService {
  Dio client;

  DetalleConsultaService() : client = ClientFactory.buildClient();

  DetalleConsultaService.withClient(
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

  Future<Response<dynamic>> createConsulta({
    required int idcita,
    required int idempleado,
    required String sintomas,
    required String diagnostico,
  }) async {
    return await client.post(
      createConsultaPath,
      data: {
        'idcita': idcita,
        'idempleado': idempleado,
        'sintomas': sintomas,
        'diagnostico': diagnostico,
      },
    );
  }

  Future<Response<dynamic>> updateConsulta({
    required int idConsulta,
    required int idcita,
    required int idempleado,
    required String sintomas,
    required String diagnostico,
  }) async {
    return await client.put(
      updateConsultaPath,
      data: {
        'idconsulta': idConsulta,
        'idcita': idcita,
        'idempleado': idempleado,
        'sintomas': sintomas,
        'diagnostico': diagnostico,
      },
    );
  }
}
