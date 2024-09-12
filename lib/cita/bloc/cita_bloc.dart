import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cita/model/cita_list_model.dart';
import 'package:paraiso_canino/cita/service/cita_service.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'cita_event.dart';
part 'cita_state.dart';

class CitaBloc extends Bloc<CitaEvent, CitaState> {
  CitaBloc() : super(CitaInitial()) {
    on<CitaShown>(getCitas);
    on<CitaSaved>(createCita);
    on<CitaEdited>(updateCita);
    on<CitaDeleted>(deleteCita);
  }

  final CitaService service = CitaService();

  Future<void> getCitas(
    CitaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CitaInProgress(),
    );
    try {
      final List<CitaListModel> resp = await service.getCitas();
      emit(
        CitaSuccess(citas: resp),
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
          CitaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createCita(
    CitaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CitaInProgress(),
    );
    try {
      await service.createCita(
        name: event.name,
      );
      emit(
        CitaCreatedSuccess(),
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
          CitaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateCita(
    CitaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CitaInProgress(),
    );
    try {
      await service.updateCita(
        id: event.id,
        name: event.name,
      );
      emit(
        CitaEditedSuccess(),
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
          CitaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteCita(
    CitaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CitaInProgress(),
    );
    try {
      await service.deleteCita(
        id: event.citaId,
      );
      emit(
        CitaDeletedSuccess(),
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
          CitaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}