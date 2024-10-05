import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/model/lab_hospital_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class HospitalizacionLaboratorioService {
  Dio client;

  HospitalizacionLaboratorioService() : client = ClientFactory.buildClient();

  HospitalizacionLaboratorioService.withClient(
    this.client,
  );

  Future<Response> createLaboratorio({
    required int idhospitalizacion,
    required int idlaboratorio,
    required String resultado,
    required String fechasolicitud,
    required String fecharesultado,
  }) async {
    return await client.post(
      createHospitalLaboratorioPath,
      data: {
        "idhospitalizacion": idhospitalizacion,
        "idlaboratorio": idlaboratorio,
        "resultado": resultado,
        "fechasolicitud": fechasolicitud,
        "fecharesultado": fecharesultado,
      },
    );
  }

  Future<List<LaboratorioListModel>> getLaboratorios() async {
    final response = await client.get(
      getLaboratoriosPath,
    );
    return List<LaboratorioListModel>.from(
      response.data['data'].map(
        (laboratorio) => LaboratorioListModel.fromJson(laboratorio),
      ),
    );
  }

  Future<List<LabHospitalListModel>> getLaboratoriosByHospital({
    required int idHospitalizacion,
  }) async {
    final response = await client.get(
      getHospitalLaboratoriosPath,
      queryParameters: {
        'idhospitalizacion': idHospitalizacion,
      },
    );
    return List<LabHospitalListModel>.from(
      response.data['data'].map(
        (laboratorio) => LabHospitalListModel.fromJson(laboratorio),
      ),
    );
  }
}
