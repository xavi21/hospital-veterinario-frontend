import 'package:dio/dio.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class ConsultaService {
  Dio client;

  ConsultaService() : client = ClientFactory.buildClient();

  ConsultaService.withClient(
    this.client,
  );

  Future<List<ConsultaListModel>> getConsultas() async {
    final response = await client.get(
      getConsultasPath,
    );
    return List<ConsultaListModel>.from(
      response.data['data'].map(
        (consulta) => ConsultaListModel.fromJson(consulta),
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

  Future<Response<dynamic>> deleteConsulta({
    required int id,
  }) async {
    return await client.delete(
      deleteConsultaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
