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

  Future<Response<dynamic>> createMenu({
    required String name,
    required int orderMenu,
  }) async {
    return await client.post(
      createMenuPath,
      data: {
        'name': name,
        'ordenmenu': orderMenu,
      },
    );
  }

  Future<Response<dynamic>> updateMenu({
    required int id,
    required String name,
    required int orderMenu,
  }) async {
    return await client.put(
      updateMenuPath,
      data: {
        'idmenu': id,
        'name': name,
        'ordenmenu': orderMenu,
      },
    );
  }

  Future<Response<dynamic>> deleteMenu({
    required int id,
  }) async {
    return await client.delete(
      deleteMenuPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
