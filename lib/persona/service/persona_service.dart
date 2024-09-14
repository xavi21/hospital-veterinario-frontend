import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class PersonaService {
  Dio client;

  PersonaService() : client = ClientFactory.buildClient();

  PersonaService.withClient(
    this.client,
  );

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

  Future<Response<dynamic>> createPersona({
    required String nombre,
    required String apellido,
    required String fechaNacimiento,
    required int idGenero,
    required String direccion,
    required String telefono,
    required String correoElectronico,
    required int idEstadoCivil,
  }) async {
    return await client.post(
      createPersonaPath,
      data: {
        "nombre": nombre,
        "apellido": apellido,
        "fechanacimiento": fechaNacimiento,
        "id_genero": idGenero,
        "direccion": direccion,
        "telefono": telefono,
        "correoelectronico": correoElectronico,
        "id_estado_civil": idEstadoCivil,
      },
    );
  }

  Future<Response<dynamic>> updatePersona({
    required String fechacreacion,
    required String usuariocreacion,
    required String fechamodificacion,
    required String usuariomodificacion,
    required int idpersona,
    required String nombre,
    required String apellido,
    required String fechanacimiento,
    required int idGenero,
    required String direccion,
    required String telefono,
    required String correoelectronico,
    required int idEstadoCivil,
  }) async {
    return await client.put(
      updatePersonaPath,
      data: {
        "fechacreacion": fechacreacion,
        "usuariocreacion": usuariocreacion,
        "fechamodificacion": fechamodificacion,
        "usuariomodificacion": usuariomodificacion,
        "idpersona": idpersona,
        "nombre": nombre,
        "apellido": apellido,
        "fechanacimiento": fechanacimiento,
        "id_genero": idGenero,
        "direccion": direccion,
        "telefono": telefono,
        "correoelectronico": correoelectronico,
        "id_estado_civil": idEstadoCivil,
      },
    );
  }

  Future<Response<dynamic>> deletePersona({
    required int id,
  }) async {
    return await client.delete(
      deletePersonaPath,
      queryParameters: {
        'id': id,
      },
    );
  }
}
