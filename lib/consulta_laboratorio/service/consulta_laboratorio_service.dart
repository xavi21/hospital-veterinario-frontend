import 'package:dio/dio.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/consulta_laboratorio_model.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class ConsultaLaboratorioService {
  Dio client;

  ConsultaLaboratorioService() : client = ClientFactory.buildClient();

  ConsultaLaboratorioService.withClient(
    this.client,
  );

  Future<Response> createLaboratorio({
    required int idconsulta,
    required int idlaboratorio,
    required String resultado,
    required String fechasolicitud,
    required String fecharesultado,
  }) async {
    return await client.post(
      createConsultaLaboratorioPath,
      data: {
        "idconsulta": idconsulta,
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

  Future<List<ConsultaLaboratorioModel>> getLaboratoriosByConsulta({
    required int idConsulta,
  }) async {
    final response = await client.get(
      getLaboratoriosByConsultaPath,
      queryParameters: {
        'idconsulta': idConsulta,
      },
    );
    return List<ConsultaLaboratorioModel>.from(
      response.data['data'].map(
        (laboratorio) => ConsultaLaboratorioModel.fromJson(laboratorio),
      ),
    );
  }
}
