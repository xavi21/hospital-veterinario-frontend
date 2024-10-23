import 'package:dio/dio.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';
import 'package:paraiso_canino/tipoMascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';
import 'package:paraiso_canino/tipoMascota/model/tipo_mascota_list_model.dart';

class TipoMascotaService {
  Dio client;

  TipoMascotaService() : client = ClientFactory.buildClient();

  TipoMascotaService.withClient(
    this.client,
  );

  Future<List<TipoMascotaListModel>> getTipoMascotas() async {
    final response = await client.get(
      getTipoMascotasPath,
    );
    return List<TipoMascotaListModel>.from(
      response.data['data'].map(
        (tipoMascota) => TipoMascotaListModel.fromJson(tipoMascota),
      ),
    );
  }

  Future<List<GeneroListModel>> getGenero() async {
    final response = await client.get(
      getGenerosPath,
    );
    return List<GeneroListModel>.from(
      response.data['data'].map(
        (genero) => GeneroListModel.fromJson(genero),
      ),
    );
  }

  Future<List<PersonaListModel>> getPersona() async {
    final response = await client.get(
      getPersonasPath,
    );
    return List<PersonaListModel>.from(
      response.data['data'].map(
        (persona) => PersonaListModel.fromJson(persona),
      ),
    );
  }

  Future<List<ColorListModel>> getColors() async {
    final response = await client.get(
      getColorsPath,
    );
    return List<ColorListModel>.from(
      response.data['data'].map(
        (color) => ColorListModel.fromJson(color),
      ),
    );
  }

  Future<List<TallaListModel>> getTallas() async {
    final response = await client.get(
      getTallasPath,
    );
    return List<TallaListModel>.from(
      response.data['data'].map(
        (talla) => TallaListModel.fromJson(talla),
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

  Future<Response<dynamic>> createMascota({
    required int idTipoMascota,
    required int idGenero,
    required int idPersona,
    required int idColor,
    required int idTalla,
    required String name,
    required String peso,
  }) async {
    return await client.post(
      createMascotaPath,
      data: {
        "idTipoMascota": idTipoMascota,
        "id_genero": idGenero,
        "idpersona": idPersona,
        "idColor": idColor,
        "idTalla": idTalla,
        "nombre": name,
        "peso": peso,
      },
    );
  }

  Future<Response<dynamic>> updateMascota({
    required int id,
    required int idTipoMascota,
    required int idGenero,
    required int idPersona,
    required int idColor,
    required int idTalla,
    required String name,
    required String peso,
  }) async {
    return await client.put(
      updateTipoMascotaPath,
      data: {
        "fechacreacion": "${DateTime.now()}",
        "usuariocreacion": "jsalazar",
        "fechamodificacion": "${DateTime.now()}",
        "usuariomodificacion": "jsalazar",
        "idmascota": id,
        "idTipoMascota": idTipoMascota,
        "id_genero": idGenero,
        "idpersona": idPersona,
        "idColor": idColor,
        "idTalla": idTalla,
        "nombre": name,
        "peso": peso,
      },
    );
  }

  // Future<Response<dynamic>> deleteMascota({
  //   required int id,
  // }) async {
  //   return await client.delete(
  //     deleteTipoMascotaPath,
  //     queryParameters: {
  //       'id': id,
  //     },
  //   );
  // }
}
