import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/jaula_list_model.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/model/mascota_list_model.dart';
import 'package:paraiso_canino/detalle_hospitalizacion/service/detalle_hospitalizacion_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'detallehospitalizacion_event.dart';
part 'detallehospitalizacion_state.dart';

class DetallehospitalizacionBloc
    extends Bloc<DetallehospitalizacionEvent, DetallehospitalizacionState> {
  DetallehospitalizacionBloc() : super(DetallehospitalizacionInitial()) {
    on<MascotasListShown>(getMascotas);
    on<JaulasListShown>(getJaulas);
    on<HospitalizacionSaved>(createHospitalizacion);
    on<HospitalizacionEdited>(updateHospitalizacion);
  }

  final DetalleHospitalizacionService service = DetalleHospitalizacionService();

  Future<void> getMascotas(
    MascotasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleHospitalizacionInProgress(),
    );
    try {
      final List<MascotaModel> resp = await service.getMascotas();
      emit(
        HospitalizacionMascotaSuccess(mascotas: resp),
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
          DetalleHospitalizacionServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getJaulas(
    JaulasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleHospitalizacionInProgress(),
    );
    try {
      final List<JaulaModel> resp = await service.getJaulas();
      emit(
        DetalleHospitalizacionJaulaListSuccess(jaulas: resp),
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
          DetalleHospitalizacionServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createHospitalizacion(
    HospitalizacionSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleHospitalizacionInProgress(),
    );
    try {
      final resp = await service.createHospitalizacion(
        idmascota: event.idmascota,
        idjaula: event.idjaula,
        fechaingreso: event.fechaingreso,
        fechasalida: event.fechasalida,
        motivo: event.motivo,
        observaciones: event.observaciones,
      );
      emit(
        HospitalizacionCreatedSuccess(
          idHospitalizacion: resp.data['data']['idhospitalizacion'],
        ),
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
          DetalleHospitalizacionServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateHospitalizacion(
    HospitalizacionEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DetalleHospitalizacionInProgress(),
    );
    try {
      await service.updateHospitalizacion(
        idhospitalizacion: event.idhospitalizacion,
        idmascota: event.idmascota,
        idjaula: event.idjaula,
        fechaingreso: event.fechaingreso,
        fechasalida: event.fechasalida,
        motivo: event.motivo,
        observaciones: event.observaciones,
      );
      emit(
        HospitalizacionEditedSuccess(),
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
          DetalleHospitalizacionServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
