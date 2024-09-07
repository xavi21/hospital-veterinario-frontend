import 'package:dio/dio.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class ColorService {
  Dio client;

  ColorService() : client = ClientFactory.buildClient();

  ColorService.withClient(
    this.client,
  );

  Future<List<ColorListModel>> getColors() async {
    final response = await client.get(
      getColorsPath,
    );
    return List<ColorListModel>.from(
      response.data['data'].map(
        (sucursal) => ColorListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createColor({
    required String name,
  }) async {
    return await client.post(
      createColorPath,
      data: {
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> updateColor({
    required int id,
    required String name,
  }) async {
    return await client.put(
      updateColorPath,
      data: {
        'idColor': id,
        'nombre': name,
      },
    );
  }

  Future<Response<dynamic>> deleteColor({
    required int id,
  }) async {
    return await client.delete(
      deleteColorPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
