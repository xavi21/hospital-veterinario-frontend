import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/mascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class MascotaService {
  Dio client;

  MascotaService() : client = ClientFactory.buildClient();

  MascotaService.withClient(
    this.client,
  );

  Future<List<MascotaListModel>> getMascotas() async {
    final response = await client.get(
      getMascotasPath,
    );
    return List<MascotaListModel>.from(
      response.data['data'].map(
        (sucursal) => MascotaListModel.fromJson(sucursal),
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
