import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/statusUsuario/model/status_usuario_response.dart';

class StatusUsuarioService {
  Dio client;

  StatusUsuarioService() : client = ClientFactory.buildClient();

  StatusUsuarioService.withClient(
    this.client,
  );

  Future<List<StatusUsuarioListModel>> getStatusUsuarios() async {
    final response = await client.get(
      getStatusUsuariosPath,
    );
    return List<StatusUsuarioListModel>.from(
      response.data['data'].map(
        (sucursal) => StatusUsuarioListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createStatusUsuario({
    required String name,
  }) async {
    return await client.post(
      createStatusUsuarioPath,
      data: {
        'name': name,
      },
    );
  }

  Future<Response<dynamic>> updateStatusUsuario({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateStatusUsuarioPath,
      data: {
        'idstatususuario': id,
        'name': name,
      },
    );
  }

  Future<Response<dynamic>> deleteStatusUsuario({
    required int id,
  }) async {
    return await client.delete(
      deleteStatusUsuarioPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
