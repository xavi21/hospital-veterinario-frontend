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
}
