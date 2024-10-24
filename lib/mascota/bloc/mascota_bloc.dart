import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/mascota/model/tipo_mascota_list_model.dart';
import 'package:paraiso_canino/mascota/service/mascota_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'mascota_event.dart';
part 'mascota_state.dart';

class TipoMascotaBloc extends Bloc<TipoMascotaEvent, TipoMascotaState> {
  TipoMascotaBloc() : super(TipoMascotaInitial()) {
    on<TipoMascotaShown>(getTipoMascotas);
    on<MascotaSaved>(createMascota);
    on<MascotaEdited>(updateMascota);
    on<MascotaDeleted>(deleteMascota);
  }

  final MascotaService service = MascotaService();

  Future<void> getTipoMascotas(
    TipoMascotaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      final List<TipoMascotaListModel> resp = await service.getTipoMascotas();
      emit(
        TipoMascotaSuccess(tipoMascotas: resp),
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
          TipoMascotaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createMascota(
    MascotaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      await service.createMascota(
        name: event.name,
      );
      emit(
        TipoMascotaCreatedSuccess(),
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
          TipoMascotaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateMascota(
    MascotaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      await service.updateMascota(
        id: event.id,
        name: event.name,
      );
      emit(
        TipoMascotaEditedSuccess(),
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
          TipoMascotaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteMascota(
    MascotaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      await service.deleteMascota(
        id: event.mascotaId,
      );
      emit(
        TipoMascotaDeletedSuccess(),
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
          TipoMascotaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
