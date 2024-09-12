import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/statusUsuario/model/status_usuario_response.dart';
import 'package:paraiso_canino/statusUsuario/service/status_usuario_service.dart';

part 'statususuario_event.dart';
part 'statususuario_state.dart';

class StatusUsuarioBloc extends Bloc<StatususuarioEvent, StatususuarioState> {
  StatusUsuarioBloc() : super(StatususuarioInitial()) {
    on<StatusUsuarioShown>(getStatusUsuarios);
    on<StatusUsuarioSaved>(createStatusUsuario);
    on<StatusUsuarioEdited>(updateStatusUsuario);
    on<StatusUsuarioDeleted>(deleteStatusUsuario);
  }

  final StatusUsuarioService service = StatusUsuarioService();

  Future<void> getStatusUsuarios(
    StatusUsuarioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusUsuarioInProgress(),
    );
    try {
      final List<StatusUsuarioListModel> resp =
          await service.getStatusUsuarios();
      emit(
        StatusUsuarioSuccess(statusUsuarios: resp),
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
          StatusUsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createStatusUsuario(
    StatusUsuarioSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusUsuarioInProgress(),
    );
    try {
      await service.createStatusUsuario(
        name: event.name,
      );
      emit(
        StatusUsuarioCreatedSuccess(),
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
          StatusUsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateStatusUsuario(
    StatusUsuarioEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusUsuarioInProgress(),
    );
    try {
      await service.updateStatusUsuario(
        id: event.id,
        name: event.name,
      );
      emit(
        StatusUsuarioEditedSuccess(),
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
          StatusUsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteStatusUsuario(
    StatusUsuarioDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      StatusUsuarioInProgress(),
    );
    try {
      await service.deleteStatusUsuario(
        id: event.statusUsuarioId,
      );
      emit(
        StatusUsuarioDeletedSuccess(),
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
          StatusUsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
