import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/medicamento/model/casa_medica_model.dart';
import 'package:paraiso_canino/medicamento/model/componente_principal_model.dart';
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

  Future<List<CasaMedicaListModel>> getCasaMedicas() async {
    final response = await client.get(
      getCasaMedicasPath,
    );
    return List<CasaMedicaListModel>.from(
      response.data['data'].map(
        (casaMedica) => CasaMedicaListModel.fromJson(casaMedica),
      ),
    );
  }

  Future<List<ComponentePrincipalListModel>> getComponentePrincipal() async {
    final response = await client.get(
      getComponentePrincipalsPath,
    );
    return List<ComponentePrincipalListModel>.from(
      response.data['data'].map(
        (medicamento) => ComponentePrincipalListModel.fromJson(medicamento),
      ),
    );
  }

  Future<Response<dynamic>> createMedicamento({
    required String name,
    required String description,
    required int idCasaMeidca,
    required int idComponentePrincipal,
  }) async {
    return await client.delete(
      createMedicamentoPath,
      data: {
        "nombre": name,
        "descripcion": description,
        "idcasamedica": idCasaMeidca,
        "idcomponenteprincipal": idComponentePrincipal,
      },
    );
  }

  Future<Response<dynamic>> updateMedicamento({
    required int id,
    required String name,
    required String description,
    required int idCasaMeidca,
    required int idComponentePrincipal,
  }) async {
    return await client.delete(
      updateMedicamentoPath,
      data: {
        "idmedicamento": id,
        "nombre": name,
        "descripcion": description,
        "idcasamedica": idCasaMeidca,
        "idcomponenteprincipal": idComponentePrincipal,
      },
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
