import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/statusEmpleado/model/status_empleado_response.dart';
import 'package:paraiso_canino/statusEmpleado/service/status_empleado_service.dart';

part 'statusempleado_event.dart';
part 'statusempleado_state.dart';

class StatusEmpleadoBloc
    extends Bloc<StatusEmpleadoEvent, StatusEmpleadoState> {
  StatusEmpleadoBloc() : super(StatusEmpleadoInitial()) {
    on<StatusEmpleadoShown>(getStatusEmpleado);
    on<StatusEmpleadoSaved>(createStatusEmpleado);
    on<StatusEmpleadoEdited>(updateStatusEmpleado);
    on<StatusEmpleadoDeleted>(deleteStatusEmpleado);
  }

  final StatusEmpleadoService service = StatusEmpleadoService();

  Future<void> getStatusEmpleado(
    StatusEmpleadoShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusEmpleadoInProgress(),
    );
    try {
      final List<StatusEmpleadoListModel> resp =
          await service.getStatusEmpleados();
      emit(
        StatusEmpleadoSuccess(statusEmpleados: resp),
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
          StatusEmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createStatusEmpleado(
    StatusEmpleadoSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusEmpleadoInProgress(),
    );
    try {
      await service.createStatusEmpleado(
        name: event.name,
      );
      emit(
        StatusEmpleadoCreatedSuccess(),
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
          StatusEmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateStatusEmpleado(
    StatusEmpleadoEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusEmpleadoInProgress(),
    );
    try {
      await service.updateStatusEmpleado(
        id: event.id,
        name: event.name,
      );
      emit(
        StatusEmpleadoEditedSuccess(),
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
          StatusEmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteStatusEmpleado(
    StatusEmpleadoDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusEmpleadoInProgress(),
    );
    try {
      await service.deleteStatusEmpleado(
        id: event.statusEmpleadoID,
      );
      emit(
        StatusEmpleadoDeletedSuccess(),
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
          StatusEmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
