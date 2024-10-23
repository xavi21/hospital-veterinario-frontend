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

  Future<Response<dynamic>> createCliente({
    required String nombre,
    required String apellido,
    required String fechaNacimiento,
    required int idGenero,
    required String direccion,
    required String telefono,
    required String correoElectronico,
    required int idEstadoCivil,
  }) async {
    return await client.post(
      createClientePath,
      data: {
        "nombre": nombre,
        "apellido": apellido,
        "fechanacimiento": fechaNacimiento,
        "id_genero": idGenero,
        "direccion": direccion,
        "telefono": telefono,
        "correoelectronico": correoElectronico,
        "id_estado_civil": idEstadoCivil,
      },
    );
  }

  Future<Response<dynamic>> updateCliente({
    required String fechacreacion,
    required String usuariocreacion,
    required String fechamodificacion,
    required String usuariomodificacion,
    required int idpersona,
    required String nombre,
    required String apellido,
    required String fechanacimiento,
    required int idGenero,
    required String direccion,
    required String telefono,
    required String correoelectronico,
    required int idEstadoCivil,
  }) async {
    return await client.put(
      updateClientePath,
      data: {
        "fechacreacion": fechacreacion,
        "usuariocreacion": usuariocreacion,
        "fechamodificacion": fechamodificacion,
        "usuariomodificacion": usuariomodificacion,
        "idpersona": idpersona,
        "nombre": nombre,
        "apellido": apellido,
        "fechanacimiento": fechanacimiento,
        "id_genero": idGenero,
        "direccion": direccion,
        "telefono": telefono,
        "correoelectronico": correoelectronico,
        "id_estado_civil": idEstadoCivil,
      },
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
