import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/opciones/model/opciones_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class OpcionesService {
  Dio client;

  OpcionesService() : client = ClientFactory.buildClient();

  OpcionesService.withClient(
    this.client,
  );

  Future<List<OpcionesListModel>> getOptions() async {
    final resp = await client.get(
      getOptionsPath,
    );
    return List<OpcionesListModel>.from(
      resp.data['data'].map(
        (option) => OpcionesListModel.fromJson(option),
      ),
    );
  }

  Future<Response<dynamic>> addNewOption({
    required String name,
    required int orderMenu,
    required String pagina,
  }) async {
    return await client.post(
      saveOptionPath,
      data: {
        'name': name,
        'ordenmenu': orderMenu,
        'pagina': '/$pagina',
      },
    );
  }

  Future<Response<dynamic>> updateOption({
    required int idOpcion,
    required String name,
    required int orderMenu,
    required String pagina,
  }) async {
    return await client.put(
      updateOptionPath,
      data: {
        'idopcion': idOpcion,
        'name': name,
        'ordenmenu': orderMenu,
        'pagina': '/$pagina',
      },
    );
  }

  Future<Response<dynamic>> deleteOption({
    required int id,
  }) async {
    return await client.delete(
      deleteOptionPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
