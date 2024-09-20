import 'package:dio/dio.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class AmbulanciaService {
  Dio client;

  AmbulanciaService() : client = ClientFactory.buildClient();

  AmbulanciaService.withClient(
    this.client,
  );

  Future<List<AmbulanciaListModel>> getAmbulancia() async {
    final response = await client.get(
      getAmbulanciasPath,
    );
    return List<AmbulanciaListModel>.from(
      response.data['data'].map(
        (ambulancia) => AmbulanciaListModel.fromJson(ambulancia),
      ),
    );
  }

  Future<Response<dynamic>> createAmbulancia({
    required String placa,
    required String marca,
    required String modelo,
    required String latitud,
    required String longitud,
    required int idEmpleado,
  }) async {
    return await client.post(
      createAmbulanciaPath,
      data: {
        "placa": placa,
        "marca": marca,
        "modelo": modelo,
        "latitud": latitud,
        "longitud": longitud,
        "idEmpleado": idEmpleado,
      },
    );
  }

  Future<Response<dynamic>> updateAmbulancia({
    required String placa,
    required String marca,
    required String modelo,
    required String latitud,
    required String longitud,
    required int idEmpleado,
    required int idAmbulancia,
  }) async {
    return await client.put(
      updateAmbulanciaPath,
      data: {
        "idAmbulancia": idAmbulancia,
        "placa": placa,
        "marca": marca,
        "modelo": modelo,
        "latitud": latitud,
        "longitud": longitud,
        "idEmpleado": idEmpleado,
      },
    );
  }

  Future<Response<dynamic>> deleteAmbulancia({
    required int id,
  }) async {
    return await client.delete(
      deleteAmbulanciaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
