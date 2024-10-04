import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/consulta_laboratorio_model.dart';
import 'package:paraiso_canino/consulta_laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/consulta_laboratorio/service/consulta_laboratorio_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'consultalaboratorio_event.dart';
part 'consultalaboratorio_state.dart';

class ConsultalaboratorioBloc
    extends Bloc<ConsultalaboratorioEvent, ConsultalaboratorioState> {
  ConsultalaboratorioBloc() : super(ConsultalaboratorioInitial()) {
    on<LaboratorioShown>(getLaboratorios);
    on<LaboratorioCreated>(createLaboratorio);
    on<LaboratorioByConsultaShown>(getLaboratoriosById);
  }

  final ConsultaLaboratorioService service = ConsultaLaboratorioService();

  Future<void> createLaboratorio(
    LaboratorioCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ConsultalaboratorioInProgress(),
    );
    try {
      await service.createLaboratorio(
        idconsulta: event.idconsulta,
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
          ConsultalaboratorioServiceError(
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
      ConsultalaboratorioInProgress(),
    );
    try {
      final List<LaboratorioListModel> resp = await service.getLaboratorios();
      emit(
        ConsultalaboratorioListSuccess(laboratorios: resp),
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
          ConsultalaboratorioServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getLaboratoriosById(
    LaboratorioByConsultaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ConsultalaboratorioInProgress(),
    );
    try {
      final resp = await service.getLaboratoriosByConsulta(
        idConsulta: event.idConsulta,
      );
      emit(
        ConsultalaboratorioByConsultaSuccess(laboratorios: resp),
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
          ConsultalaboratorioServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
