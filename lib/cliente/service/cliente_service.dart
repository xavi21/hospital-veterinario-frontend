import 'package:dio/dio.dart';
import 'package:paraiso_canino/cliente/model/cliente_response.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class ClienteService {
  Dio client;

  ClienteService() : client = ClientFactory.buildClient();

  ClienteService.withClient(
    this.client,
  );

  Future<List<ClienteListModel>> getClientes() async {
    final response = await client.get(
      getClientesPath,
    );
    return List<ClienteListModel>.from(
      response.data['data'].map(
        (cliente) => ClienteListModel.fromJson(cliente),
      ),
    );
  }

  Future<Response<dynamic>> deleteCliente({
    required int id,
  }) async {
    return await client.delete(
      deleteClientePath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
