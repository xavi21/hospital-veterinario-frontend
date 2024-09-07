import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/mascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/mascota/service/mascota_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'mascota_event.dart';
part 'mascota_state.dart';

class MascotaBloc extends Bloc<MascotaEvent, MascotaState> {
  MascotaBloc() : super(MascotaInitial()) {
    on<MascotaShown>(getMascotas);
    on<MascotaSaved>(createMascota);
    on<MascotaEdited>(updateMascota);
    on<MascotaDeleted>(deleteMascota);
  }

  final MascotaService service = MascotaService();

  Future<void> getMascotas(
    MascotaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MascotaInProgress(),
    );
    try {
      final List<MascotaListModel> resp = await service.getMascotas();
      emit(
        MascotaSuccess(mascotas: resp),
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
          MascotaError(
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
      MascotaInProgress(),
    );
    try {
      await service.createMascota(
        name: event.name,
      );
      emit(
        MascotaCreatedSuccess(),
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
          MascotaError(
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
      MascotaInProgress(),
    );
    try {
      await service.updateMascota(
        id: event.id,
        name: event.name,
      );
      emit(
        MascotaEditedSuccess(),
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
          MascotaError(
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
      MascotaInProgress(),
    );
    try {
      await service.deleteMascota(
        id: event.mascotaId,
      );
      emit(
        MascotaDeletedSuccess(),
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
          MascotaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
