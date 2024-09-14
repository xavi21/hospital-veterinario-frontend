import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/jaula/model/jaula_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class JaulaService {
  Dio client;

  JaulaService() : client = ClientFactory.buildClient();

  JaulaService.withClient(
    this.client,
  );

  Future<List<JaulaListModel>> getJaula() async {
    final response = await client.get(
      getJaulasPath,
    );
    return List<JaulaListModel>.from(
      response.data['data'].map(
        (jaula) => JaulaListModel.fromJson(jaula),
      ),
    );
  }

  Future<Response<dynamic>> createJaula({
    required String descripcion,
  }) async {
    return await client.post(
      createJaulaPath,
      data: {
        'descripcion': descripcion,
      },
    );
  }

  Future<Response<dynamic>> updateJaula({
    required int idJaula,
    required String descripcion,
  }) async {
    return await client.put(
      updateJaulaPath,
      data: {
        'idJaula': idJaula,
        'descripcion': descripcion,
      },
    );
  }

  Future<Response<dynamic>> deleteJaula({
    required int id,
  }) async {
    return await client.delete(
      deleteJaulaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
