import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/receta/model/medicina_list_model.dart';
import 'package:paraiso_canino/receta/model/receta_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class RecetaService {
  Dio client;

  RecetaService() : client = ClientFactory.buildClient();

  RecetaService.withClient(
    this.client,
  );

  Future<List<MedicinaListModel>> getMedicinas() async {
    final response = await client.get(
      getMedicamentosPath,
    );
    return List<MedicinaListModel>.from(
      response.data['data'].map(
        (medicamento) => MedicinaListModel.fromJson(medicamento),
      ),
    );
  }

  Future<List<RecetaListModel>> getDetalleRecetas({
    required int idReceta,
  }) async {
    final response = await client.get(
      getDetalleRecetasByIdPath,
      queryParameters: {
        'idreceta': idReceta,
      },
    );
    return List<RecetaListModel>.from(
      response.data['data'].map(
        (receta) => RecetaListModel.fromJson(receta),
      ),
    );
  }

  Future<Response> newReceta({
    required int idConsulta,
    required String observaciones,
  }) async {
    return await client.post(
      createRecetaPath,
      data: {
        "idconsulta": idConsulta,
        "observaciones": observaciones,
      },
    );
  }

  Future<Response> newDetalleReceta({
    required int cantidad,
    required int idReceta,
    required int idMedicamento,
    required String indicaciones,
  }) async {
    return await client.post(
      createDetalleRecetaPath,
      data: {
        "idreceta": idReceta,
        "idmedicamento": idMedicamento,
        "cantidad": cantidad,
        "indicaciones": indicaciones,
      },
    );
  }
}
