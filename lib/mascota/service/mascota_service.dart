import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/mascota/model/tipo_mascota_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class MascotaService {
  Dio client;

  MascotaService() : client = ClientFactory.buildClient();

  MascotaService.withClient(
    this.client,
  );

  Future<List<TipoMascotaListModel>> getTipoMascotas() async {
    final response = await client.get(
      getTipoMascotasPath,
    );
    return List<TipoMascotaListModel>.from(
      response.data['data'].map(
        (tipoMascota) => TipoMascotaListModel.fromJson(tipoMascota),
      ),
    );
  }

  Future<Response<dynamic>> createMascota({
    required String name,
  }) async {
    return await client.post(
      createTipoMascotaPath,
      data: {
        "nombre": name,
      },
    );
  }

  Future<Response<dynamic>> updateMascota({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateTipoMascotaPath,
      data: {
        "idTipoMascota": id,
        "nombre": name,
      },
    );
  }

  Future<Response<dynamic>> deleteMascota({
    required int id,
  }) async {
    return await client.delete(
      deleteTipoMascotaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
