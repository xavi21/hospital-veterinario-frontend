import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:paraiso_canino/cita/model/cita_list_model.dart';
import 'package:paraiso_canino/cita/model/mascota_list_model.dart';
import 'package:paraiso_canino/cita/model/status_cita_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class CitaService {
  Dio client;

  CitaService() : client = ClientFactory.buildClient();

  CitaService.withClient(
    this.client,
  );

  Future<List<CitaListModel>> getCitas() async {
    final response = await client.get(
      getCitasPath,
    );
    return List<CitaListModel>.from(
      response.data['data'].map(
        (cita) => CitaListModel.fromJson(cita),
      ),
    );
  }

  Future<List<StatusCitaListModel>> getStatusCitas() async {
    final response = await client.get(
      getStatusCitasPath,
    );
    return List<StatusCitaListModel>.from(
      response.data['data'].map(
        (statusCita) => StatusCitaListModel.fromJson(statusCita),
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

  Future<Response<dynamic>> createCita({
    required int idMascota,
    required int idStatusCita,
    required String motivo,
  }) async {
    return await client.post(
      createCitaPath,
      data: {
        "fechahora":
            DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(DateTime.now()),
        "idmascota": idMascota,
        "idstatuscita": idStatusCita,
        "motivo": motivo,
      },
    );
  }

  Future<Response<dynamic>> updateCita({
    required int idCita,
    required int idMascota,
    required int idStatusCita,
    required String motivo,
  }) async {
    return await client.put(
      updateCitaPath,
      data: {
        "idcita": idCita,
        "fechahora":
            DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").format(DateTime.now()),
        "idmascota": idMascota,
        "idstatuscita": idStatusCita,
        "motivo": motivo,
      },
    );
  }

  Future<Response<dynamic>> deleteCita({
    required int id,
  }) async {
    return await client.delete(
      deleteCitaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
