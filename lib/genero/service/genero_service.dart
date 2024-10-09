import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class GeneroService {
  Dio client;

  GeneroService() : client = ClientFactory.buildClient();

  GeneroService.withClient(
    this.client,
  );

  Future<List<GeneroListModel>> getGenero() async {
    final response = await client.get(
      getGenerosPath,
    );
    return List<GeneroListModel>.from(
      response.data['data'].map(
        (genero) => GeneroListModel.fromJson(genero),
      ),
    );
  }

  Future<Response<dynamic>> deleteGenero({
    required int id,
  }) async {
    return await client.delete(
      deleteGeneroPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
