import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/medicamento/model/medicamento_response.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class MedicamentoService {
  Dio client;

  MedicamentoService() : client = ClientFactory.buildClient();

  MedicamentoService.withClient(
    this.client,
  );

  Future<List<MedicamentoListModel>> getMedicamentos() async {
    final response = await client.get(
      getMedicamentosPath,
    );
    return List<MedicamentoListModel>.from(
      response.data['data'].map(
        (medicamento) => MedicamentoListModel.fromJson(medicamento),
      ),
    );
  }

  Future<Response<dynamic>> deleteMedicamento({
    required int id,
  }) async {
    return await client.delete(
      deleteMedicamentoPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
