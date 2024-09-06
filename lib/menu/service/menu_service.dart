import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/menu/model/menu_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class MenuService {
  Dio client;

  MenuService() : client = ClientFactory.buildClient();

  MenuService.withClient(
    this.client,
  );

  Future<List<MenuModel>> getMenu() async {
    final response = await client.get(
      getMenuPath,
    );
    return List<MenuModel>.from(
      response.data['data'].map(
        (sucursal) => MenuModel.fromJson(sucursal),
      ),
    );
  }
}
