import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/casaMedica/model/cada_medica_model.dart';
import 'package:paraiso_canino/casaMedica/service/casa_medica_service.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'casamedica_event.dart';
part 'casamedica_state.dart';

class CasamedicaBloc extends Bloc<CasamedicaEvent, CasamedicaState> {
  CasamedicaBloc() : super(CasamedicaInitial()) {
    on<CasaMedicaShown>(getCasaMedicas);
    on<CasaMedicaSaved>(createCasaMedica);
    on<CasaMedicaEdited>(updateCasaMedica);
    on<CasaMedicaDeleted>(deleteCasaMedica);
  }

  final CasaMedicaService service = CasaMedicaService();

  Future<void> getCasaMedicas(
    CasaMedicaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CasaMedicaInProgress(),
    );
    try {
      final List<CasaMedicaListModel> resp = await service.getCasaMedicas();
      emit(
        CasaMedicaSuccess(casasMedicas: resp),
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
          CasaMedicaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createCasaMedica(
    CasaMedicaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CasaMedicaInProgress(),
    );
    try {
      await service.createCasaMedica(
        name: event.name,
        nombreComercial: event.nombreComercial,
      );
      emit(
        CasaMedicaCreatedSuccess(),
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
          CasaMedicaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateCasaMedica(
    CasaMedicaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CasaMedicaInProgress(),
    );
    try {
      await service.updateCasaMedica(
        id: event.id,
        name: event.name,
        nombreComercial: event.nombreComercial,
      );
      emit(
        CasaMedicaEditedSuccess(),
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
          CasaMedicaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteCasaMedica(
    CasaMedicaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      CasaMedicaInProgress(),
    );
    try {
      await service.deleteCasaMedica(
        id: event.id,
      );
      emit(
        CasaMedicaDeletedSuccess(),
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
          CasaMedicaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
