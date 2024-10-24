import 'package:dio/dio.dart';
import 'package:paraiso_canino/casaMedica/model/cada_medica_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class CasaMedicaService {
  Dio client;

  CasaMedicaService() : client = ClientFactory.buildClient();

  CasaMedicaService.withClient(
    this.client,
  );

  Future<List<CasaMedicaListModel>> getCasaMedicas() async {
    final response = await client.get(
      getCasaMedicasPath,
    );
    return List<CasaMedicaListModel>.from(
      response.data['data'].map(
        (casaMedica) => CasaMedicaListModel.fromJson(casaMedica),
      ),
    );
  }

  Future<Response<dynamic>> createCasaMedica({
    required String name,
    required String nombreComercial,
  }) async {
    return await client.post(
      createCasaMedicaPath,
      data: {
        "nombre": name,
        "nombrecomercial": nombreComercial,
      },
    );
  }

  Future<Response<dynamic>> updateCasaMedica({
    required int id,
    required String name,
    required String nombreComercial,
  }) async {
    return await client.put(
      updateCasaMedicaPath,
      data: {
        "idcasamedica": id,
        "nombre": name,
        "nombrecomercial": nombreComercial,
      },
    );
  }

  Future<Response<dynamic>> deleteCasaMedica({
    required int id,
  }) async {
    return await client.delete(
      deleteCasaMedicaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
