import 'package:dio/dio.dart';
import 'package:paraiso_canino/dashboard/model/consulta_response.dart';
import 'package:paraiso_canino/dashboard/model/grooming_list_model.dart';
import 'package:paraiso_canino/dashboard/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/dashboard/model/mascota_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class DashboardService {
  Dio client;

  DashboardService() : client = ClientFactory.buildClient();

  DashboardService.withClient(
    this.client,
  );

  Future<List<ConsultaListModel>> getConsultas() async {
    final response = await client.get(
      getConsultasPath,
    );
    return List<ConsultaListModel>.from(
      response.data['data'].map(
        (consulta) => ConsultaListModel.fromJson(consulta),
      ),
    );
  }

  Future<List<GroomingListModel>> getGrooming() async {
    final response = await client.get(
      getGroomingsPath,
    );
    return List<GroomingListModel>.from(
      response.data['data'].map(
        (grooming) => GroomingListModel.fromJson(grooming),
      ),
    );
  }

  Future<List<MascotaListModel>> getMascotas() async {
    final response = await client.get(
      getMascotasPath,
    );
    return List<MascotaListModel>.from(
      response.data['data'].map(
        (mascota) => MascotaListModel.fromJson(mascota),
      ),
    );
  }

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
