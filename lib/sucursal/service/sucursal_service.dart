import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/sucursal/model/sucursal_response.dart';

class SucursalService {
  Dio client;

  SucursalService() : client = ClientFactory.buildClient();

  SucursalService.withClient(
    this.client,
  );

  Future<List<OfficeListModel>> getOffices() async {
    final response = await client.get(
      getOfficesPath,
    );
    return List<OfficeListModel>.from(
      response.data['data'].map(
        (sucursal) => OfficeListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createOffice({
    required String name,
    required String direction,
  }) async {
    return await client.post(
      createOfficePath,
      data: {
        'name': name,
        'direccion': direction,
      },
    );
  }

  Future<Response<dynamic>> updateOffice({
    required int id,
    required String name,
    required String direction,
  }) async {
    return await client.put(
      editOfficePath,
      data: {
        'idsucursal': id,
        'name': name,
        'direccion': direction,
      },
    );
  }

  Future<Response<dynamic>> deleteOffice({
    required int id,
  }) async {
    return await client.delete(
      deleteOfficePath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
