import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/home/model/menu_list.dart';
import 'package:paraiso_canino/home/model/submenu_list.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class HomeService {
  Dio client;

  HomeService() : client = ClientFactory.buildClient();

  HomeService.withClient(
    this.client,
  );

  Future<List<MenuListModel>> getMenu() async {
    final response = await client.get(
      getMenuPath,
    );
    return List<MenuListModel>.from(
      response.data['data'].map(
        (menu) => MenuListModel.fromJson(menu),
      ),
    );
  }

  Future<List<SubMenuListModel>> getSubMenu() async {
    final response = await client.get(
      getSubMenuPath,
    );
    return List<SubMenuListModel>.from(
      response.data['data'].map(
        (subMenu) => SubMenuListModel.fromJson(subMenu),
      ),
    );
  }
}
