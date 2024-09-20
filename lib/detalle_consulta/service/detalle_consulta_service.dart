import 'package:dio/dio.dart';
import 'package:paraiso_canino/detalle_consulta/model/cita_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/model/empleado_list_model.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class DetalleConsultaService {
  Dio client;

  DetalleConsultaService() : client = ClientFactory.buildClient();

  DetalleConsultaService.withClient(
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

  Future<List<EmpeladoListModel>> getEmpleados() async {
    final response = await client.get(
      getEmpleadosPath,
    );
    return List<EmpeladoListModel>.from(
      response.data['data'].map(
        (empleado) => EmpeladoListModel.fromJson(empleado),
      ),
    );
  }
}
