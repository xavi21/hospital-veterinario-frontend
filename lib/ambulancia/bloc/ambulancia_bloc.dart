import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/ambulancia/model/ambulancia_list_model.dart';
import 'package:paraiso_canino/ambulancia/service/ambulancia_service.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'ambulancia_event.dart';
part 'ambulancia_state.dart';

class AmbulanciaBloc extends Bloc<AmbulanciaEvent, AmbulanciaState> {
  AmbulanciaBloc() : super(AmbulanciaInitial()) {
    on<AmbulanciaListShown>(getAmbulancia);
    on<AmbulanciaSaved>(createAmbulancia);
    on<AmbulanciaEdited>(updateAmbulancia);
    on<AmbulanciaDeleted>(deleteAmbulancia);
  }

  final AmbulanciaService service = AmbulanciaService();

  Future<void> getAmbulancia(
    AmbulanciaListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      AmbulanciaInProgress(),
    );
    try {
      final List<AmbulanciaListModel> resp = await service.getAmbulancia();
      emit(
        AmbulanciaListSuccess(ambulancias: resp),
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
          AmbulanciaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createAmbulancia(
    AmbulanciaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      AmbulanciaInProgress(),
    );
    try {
      await service.createAmbulancia(
        placa: event.placa,
        marca: event.marca,
        modelo: event.modelo,
        latitud: event.latitud,
        longitud: event.longitud,
        idEmpleado: event.idEmpleado,
      );
      emit(
        AmbulanciaCreatedSuccess(),
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
          AmbulanciaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateAmbulancia(
    AmbulanciaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      AmbulanciaInProgress(),
    );
    try {
      await service.updateAmbulancia(
        placa: event.placa,
        marca: event.marca,
        modelo: event.modelo,
        latitud: event.latitud,
        longitud: event.longitud,
        idEmpleado: event.idEmpleado,
        idAmbulancia: event.idAmbulancia,
      );
      emit(
        AmbulanciaEditedSuccess(),
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
          AmbulanciaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteAmbulancia(
    AmbulanciaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      AmbulanciaInProgress(),
    );
    try {
      await service.deleteAmbulancia(
        id: event.id,
      );
      emit(
        AmbulanciaDeletedSuccess(),
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
          AmbulanciaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
