import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/usuario/model/usuario_list_model.dart';

class UsuarioService {
  Dio client;

  UsuarioService() : client = ClientFactory.buildClient();

  UsuarioService.withClient(
    this.client,
  );

  Future<List<UsuarioListModel>> getUsuario() async {
    final response = await client.get(
      getUsuariosPath,
    );
    return List<UsuarioListModel>.from(
      response.data['data'].map(
        (persona) => UsuarioListModel.fromJson(persona),
      ),
    );
  }
}
