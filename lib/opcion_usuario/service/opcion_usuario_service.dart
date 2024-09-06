import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class OpcioneUsuarioService {
  Dio client;

  OpcioneUsuarioService() : client = ClientFactory.buildClient();

  OpcioneUsuarioService.withClient(
    this.client,
  );

  Future<List<OpcionUsuarioModel>> getOptions() async {
    final resp = await client.get(
      getSubMenuPath,
    );
    return List<OpcionUsuarioModel>.from(
      resp.data['data'].map(
        (option) => OpcionUsuarioModel.fromJson(option),
      ),
    );
  }
}
