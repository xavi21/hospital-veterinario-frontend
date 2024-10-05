import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/hospitalizacion_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/medicina_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class HospitalizacionMemdicamentoService {
  Dio client;

  HospitalizacionMemdicamentoService() : client = ClientFactory.buildClient();

  HospitalizacionMemdicamentoService.withClient(
    this.client,
  );

  Future<List<HospitalizacionListModel>> getHospitalizacionById({
    required int idHospitalizacion,
  }) async {
    final response = await client.get(
      getHospitalMedicamentoByIdPath,
      queryParameters: {
        'idhospitalizacion': idHospitalizacion,
      },
    );
    return List<HospitalizacionListModel>.from(
      response.data['data'].map(
        (hospitalizacion) => HospitalizacionListModel.fromJson(hospitalizacion),
      ),
    );
  }

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

  Future<Response> newHospitalizacion({
    required int idHospitalizacion,
    required int idMedicamento,
    required String observaciones,
  }) async {
    return await client.post(
      createHospitalMedicamentoPath,
      data: {
        "idhospitalizacion": idHospitalizacion,
        "idmedicamento": idMedicamento,
        "observaciones": observaciones,
      },
    );
  }
}
