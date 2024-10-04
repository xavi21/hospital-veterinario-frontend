import 'package:dio/dio.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/jaula_list_model.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/mascota_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class DetalleHospitalizacionService {
  Dio client;

  DetalleHospitalizacionService() : client = ClientFactory.buildClient();

  DetalleHospitalizacionService.withClient(
    this.client,
  );

  Future<List<MascotaModel>> getMascotas() async {
    final response = await client.get(
      getMascotasPath,
    );
    return List<MascotaModel>.from(
      response.data['data'].map(
        (mascota) => MascotaModel.fromJson(mascota),
      ),
    );
  }

  Future<List<JaulaModel>> getJaulas() async {
    final response = await client.get(
      getJaulasPath,
    );
    return List<JaulaModel>.from(
      response.data['data'].map(
        (jaula) => JaulaModel.fromJson(jaula),
      ),
    );
  }

  Future<Response<dynamic>> createHospitalizacion({
    required int idmascota,
    required int idjaula,
    required String fechaingreso,
    required String fechasalida,
    required String motivo,
    required String observaciones,
  }) async {
    return await client.post(
      createHospitalizacionPath,
      data: {
        "idmascota": idmascota,
        "idjaula": idjaula,
        "fechaingreso": fechaingreso,
        "fechasalida": fechasalida,
        "motivo": motivo,
        "observaciones": observaciones,
      },
    );
  }

  Future<Response<dynamic>> updateHospitalizacion({
    required int idhospitalizacion,
    required int idmascota,
    required int idjaula,
    required String fechaingreso,
    required String fechasalida,
    required String motivo,
    required String observaciones,
  }) async {
    return await client.put(
      updateHospitalizacionPath,
      data: {
        "idhospitalizacion": idhospitalizacion,
        "idmascota": idmascota,
        "idjaula": idjaula,
        "fechaingreso": fechaingreso,
        "fechasalida": fechasalida,
        "motivo": motivo,
        "observaciones": observaciones,
      },
    );
  }
}
