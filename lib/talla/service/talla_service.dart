import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';

class TallaService {
  Dio client;

  TallaService() : client = ClientFactory.buildClient();

  TallaService.withClient(
    this.client,
  );

  Future<List<TallaListModel>> getTallas() async {
    final response = await client.get(
      getTallasPath,
    );
    return List<TallaListModel>.from(
      response.data['data'].map(
        (sucursal) => TallaListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createTalla({
    required String name,
  }) async {
    return await client.post(
      createTallaPath,
      data: {
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> updateTalla({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateTallaPath,
      data: {
        'idTalla': id,
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> deleteTalla({
    required int id,
  }) async {
    return await client.delete(
      deleteTallaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
