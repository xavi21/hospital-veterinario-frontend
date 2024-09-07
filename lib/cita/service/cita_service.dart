import 'package:dio/dio.dart';
import 'package:paraiso_canino/cita/model/cita_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class CitaService {
  Dio client;

  CitaService() : client = ClientFactory.buildClient();

  CitaService.withClient(
    this.client,
  );

  Future<List<CitaListModel>> getCitas() async {
    final response = await client.get(
      getCitasPath,
    );
    return List<CitaListModel>.from(
      response.data['data'].map(
        (sucursal) => CitaListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createCita({
    required String name,
  }) async {
    return await client.post(
      createCitaPath,
      data: {
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> updateCita({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateCitaPath,
      data: {
        'idestatuscita': id,
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> deleteCita({
    required int id,
  }) async {
    return await client.delete(
      deleteCitaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
