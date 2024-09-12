import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/tipoMascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class TipoMascotaService {
  Dio client;

  TipoMascotaService() : client = ClientFactory.buildClient();

  TipoMascotaService.withClient(
    this.client,
  );

  Future<List<TipoMascotaListModel>> getMascotas() async {
    final response = await client.get(
      getMascotasPath,
    );
    return List<TipoMascotaListModel>.from(
      response.data['data'].map(
        (sucursal) => TipoMascotaListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createMascota({
    required String name,
  }) async {
    return await client.post(
      createMascotaPath,
      data: {
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> updateMascota({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateMascotaPath,
      data: {
        'idTipoMascota': id,
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> deleteMascota({
    required int id,
  }) async {
    return await client.delete(
      deleteMascotaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
