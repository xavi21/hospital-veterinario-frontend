import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/consulta/model/consulta_response.dart';
import 'package:paraiso_canino/consulta/service/consulta_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'consulta_event.dart';
part 'consulta_state.dart';

class ConsultaBloc extends Bloc<ConsultaEvent, ConsultaState> {
  ConsultaBloc() : super(ConsultaInitial()) {
    on<ConsultaShown>(getConsultas);
    on<ConsultaDeleted>(deleteConsulta);
  }

  final ConsultaService service = ConsultaService();

  Future<void> getConsultas(
    ConsultaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ConsultaInProgress(),
    );
    try {
      final List<ConsultaListModel> resp = await service.getConsultas();
      emit(
        ConsultaSuccess(consultas: resp),
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
          ConsultaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteConsulta(
    ConsultaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ConsultaInProgress(),
    );
    try {
      await service.deleteConsulta(
        id: event.consultaID,
      );
      emit(
        ConsultaDeletedSuccess(),
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
          ConsultaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
