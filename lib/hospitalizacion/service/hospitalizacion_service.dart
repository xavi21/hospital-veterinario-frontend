import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/hospitalizacion/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class HospitalizacionService {
  Dio client;

  HospitalizacionService() : client = ClientFactory.buildClient();

  HospitalizacionService.withClient(
    this.client,
  );

  Future<List<HospitalizacionListModel>> getHospitalizaciones() async {
    final response = await client.get(
      getHospitalizacionesPath,
    );
    return List<HospitalizacionListModel>.from(
      response.data['data'].map(
        (hospitalizacion) => HospitalizacionListModel.fromJson(hospitalizacion),
      ),
    );
  }
}
