import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/opcion_usuario/model/menu_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opciones_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class OpcioneUsuarioService {
  Dio client;

  OpcioneUsuarioService() : client = ClientFactory.buildClient();

  OpcioneUsuarioService.withClient(
    this.client,
  );

  Future<List<OpcionesListModel>> getOptionsList() async {
    final resp = await client.get(
      getOptionsPath,
    );
    return List<OpcionesListModel>.from(
      resp.data['data'].map(
        (option) => OpcionesListModel.fromJson(option),
      ),
    );
  }

  Future<List<MenuModel>> getMenuList() async {
    final response = await client.get(
      getMenuPath,
    );
    return List<MenuModel>.from(
      response.data['data'].map(
        (menu) => MenuModel.fromJson(menu),
      ),
    );
  }

  Future<List<OpcionUsuarioModel>> getOptions() async {
    final resp = await client.get(
      getSubMenuPath,
    );
    return List<OpcionUsuarioModel>.from(
      resp.data['data'].map(
        (option) => OpcionUsuarioModel.fromJson(option),
      ),
    );
  }

  Future<Response<dynamic>> createUserOption({
    required String idUsuario,
    required int idMenu,
    required int idOpcion,
    required int alta,
    required int baja,
    required int cambio,
  }) async {
    return await client.post(
      createSubMenuPath,
      data: {
        'idUsuario': idUsuario,
        'idMenu': idMenu,
        'idOpcion': idOpcion,
        'alta': alta,
        'baja': baja,
        'cambio': cambio
      },
    );
  }

  Future<Response<dynamic>> updateUserOption({
    required String idUsuario,
    required int idMenu,
    required int idOpcion,
    required int alta,
    required int baja,
    required int cambio,
  }) async {
    return await client.put(
      updateSubMenuPath,
      data: {
        'idUsuario': idUsuario,
        'idMenu': idMenu,
        'idOpcion': idOpcion,
        'alta': alta,
        'baja': baja,
        'cambio': cambio,
      },
    );
  }

  Future<Response<dynamic>> deleteUserOption({
    required String idUsuario,
    required int idMenu,
    required int idOpcion,
  }) async {
    return await client.delete(
      deleteSubMenuPath,
      queryParameters: {
        'idUsuario': idUsuario,
        'idMenu': idMenu,
        'idOpcion': idOpcion,
      },
    );
  }
}
