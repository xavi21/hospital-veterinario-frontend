import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class LaboratorioService {
  Dio client;

  LaboratorioService() : client = ClientFactory.buildClient();

  LaboratorioService.withClient(
    this.client,
  );

  Future<List<LaboratorioListModel>> getLaboratorios() async {
    final response = await client.get(
      getLaboratoriosPath,
    );
    return List<LaboratorioListModel>.from(
      response.data['data'].map(
        (sucursal) => LaboratorioListModel.fromJson(sucursal),
      ),
    );
  }

  Future<Response<dynamic>> createLaboratorio({
    required String name,
    required String descripcion,
  }) async {
    return await client.post(
      createLaboratorioPath,
      data: {
        'nombre': name,
        'descripcion': descripcion,
      },
    );
  }

  Future<Response<dynamic>> updateLaboratorio({
    required int id,
    required String name,
    required String descripcion,
  }) async {
    return await client.put(
      updateLaboratorioPath,
      data: {
        'idLaboratorio': id,
        'nombre': name,
        'descripcion': descripcion,
      },
    );
  }

  Future<Response<dynamic>> deleteLaboratorio({
    required int id,
  }) async {
    return await client.delete(
      deleteLaboratorioPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
