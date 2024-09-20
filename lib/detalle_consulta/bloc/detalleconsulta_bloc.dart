import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/detalle_consulta/model/cita_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/model/empleado_list_model.dart';
import 'package:paraiso_canino/detalle_consulta/service/detalle_consulta_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'detalleconsulta_event.dart';
part 'detalleconsulta_state.dart';

class DetalleconsultaBloc
    extends Bloc<DetalleconsultaEvent, DetalleconsultaState> {
  DetalleconsultaBloc() : super(DetalleconsultaInitial()) {
    on<CitasListShown>(getCitas);
    on<EmpleadosListShown>(getEmpleados);
  }

  final DetalleConsultaService service = DetalleConsultaService();

  Future<void> getCitas(
    CitasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleconsultaInProgress(),
    );
    try {
      final List<CitaListModel> resp = await service.getCitas();
      emit(
        DetalleconsultaCitaListSuccess(citas: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          DetalleconsultaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getEmpleados(
    EmpleadosListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleconsultaInProgress(),
    );
    try {
      final List<EmpeladoListModel> resp = await service.getEmpleados();
      emit(
        DetalleconsultaEmpleadoListSuccess(empleados: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          DetalleconsultaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
