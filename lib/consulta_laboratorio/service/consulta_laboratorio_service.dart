import 'package:dio/dio.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class ConsultaLaboratorioService {
  Dio client;

  ConsultaLaboratorioService() : client = ClientFactory.buildClient();

  ConsultaLaboratorioService.withClient(
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
}
