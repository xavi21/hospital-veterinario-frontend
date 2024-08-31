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
}
