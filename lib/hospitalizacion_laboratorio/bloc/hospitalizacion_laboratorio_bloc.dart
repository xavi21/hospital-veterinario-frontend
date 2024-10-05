import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/model/lab_hospital_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_laboratorio/service/hospitalizacion_laboratorio_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'hospitalizacion_laboratorio_event.dart';
part 'hospitalizacion_laboratorio_state.dart';

class HospitalizacionLaboratorioBloc extends Bloc<
    HospitalizacionLaboratorioEvent, HospitalizacionLaboratorioState> {
  HospitalizacionLaboratorioBloc()
      : super(HospitalizacionLaboratorioInitial()) {
    on<LaboratorioShown>(getLaboratorios);
    on<LaboratorioCreated>(createLaboratorio);
    on<LaboratorioByHospitalShown>(getLaboratoriosById);
  }

  final HospitalizacionLaboratorioService service =
      HospitalizacionLaboratorioService();

  Future<void> createLaboratorio(
    LaboratorioCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionLaboratorioInProgress(),
    );
    try {
      await service.createLaboratorio(
        idhospitalizacion: event.idhospitalizacion,
        idlaboratorio: event.idlaboratorio,
        resultado: event.resultado,
        fechasolicitud: event.fechasolicitud,
        fecharesultado: event.fecharesultado,
      );
      emit(
        LaboratorioCreatedSuccess(),
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
          HospitalizacionLaboratorioServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getLaboratorios(
    LaboratorioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionLaboratorioInProgress(),
    );
    try {
      final List<LaboratorioListModel> resp = await service.getLaboratorios();
      emit(
        HospitalizacionLaboratorioListSuccess(laboratorios: resp),
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
          HospitalizacionLaboratorioServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getLaboratoriosById(
    LaboratorioByHospitalShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionLaboratorioInProgress(),
    );
    try {
      final resp = await service.getLaboratoriosByHospital(
        idHospitalizacion: event.idhospitalizacion,
      );
      emit(
        LaboratorioByHospitalizacionSuccess(laboratorios: resp),
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
          HospitalizacionLaboratorioServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
