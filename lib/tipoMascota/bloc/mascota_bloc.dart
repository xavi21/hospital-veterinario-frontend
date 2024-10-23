import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';
import 'package:paraiso_canino/tipoMascota/model/mascota_list_model.dart';
import 'package:paraiso_canino/tipoMascota/model/tipo_mascota_list_model.dart';
import 'package:paraiso_canino/tipoMascota/service/mascota_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'mascota_event.dart';
part 'mascota_state.dart';

class TipoMascotaBloc extends Bloc<TipoMascotaEvent, TipoMascotaState> {
  TipoMascotaBloc() : super(TipoMascotaInitial()) {
    on<TipoMascotaShown>(getTipoMascotas);
    on<GeneroShown>(getGeneros);
    on<PersonaShown>(getPersonas);
    on<ColorShown>(getColores);
    on<TallaShown>(getTallas);
    on<MascotaShown>(getMascotas);
    on<MascotaSaved>(createMascota);
    on<MascotaEdited>(updateMascota);
    // on<MascotaDeleted>(deleteMascota);
  }

  final TipoMascotaService service = TipoMascotaService();

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

  Future<void> getGeneros(
    GeneroShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      final List<GeneroListModel> resp = await service.getGenero();
      emit(
        GeneroSuccess(genero: resp),
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

  Future<void> getColores(
    ColorShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      final List<ColorListModel> resp = await service.getColors();
      emit(
        ColorSuccess(colores: resp),
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

  Future<void> getPersonas(
    PersonaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      final List<PersonaListModel> resp = await service.getPersona();
      emit(
        PersonaSuccess(personas: resp),
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

  Future<void> getTallas(
    TallaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
    );
    try {
      final List<TallaListModel> resp = await service.getTallas();
      emit(
        TallaSuccess(tallas: resp),
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

  Future<void> getMascotas(
    MascotaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TipoMascotaInProgress(),
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
        idTipoMascota: event.idTipoMascota,
        idGenero: event.idGenero,
        idPersona: event.idPersona,
        idColor: event.idColor,
        idTalla: event.idTalla,
        name: event.name,
        peso: event.peso,
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
        idTipoMascota: event.idTipoMascota,
        idGenero: event.idGenero,
        idPersona: event.idPersona,
        idColor: event.idColor,
        idTalla: event.idTalla,
        name: event.name,
        peso: event.peso,
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

  // Future<void> deleteMascota(
  //   MascotaDeleted event,
  //   Emitter<BaseState> emit,
  // ) async {
  //   emit(
  //     TipoMascotaInProgress(),
  //   );
  //   try {
  //     await service.deleteMascota(
  //       id: event.mascotaId,
  //     );
  //     emit(
  //       TipoMascotaDeletedSuccess(),
  //     );
  //   } on DioException catch (error) {
  //     if (error.response?.statusCode == null ||
  //         error.response!.statusCode! >= 500 ||
  //         error.response!.data[responseCode] == null) {
  //       emit(
  //         ServerClientError(),
  //       );
  //     } else {
  //       emit(
  //         TipoMascotaError(
  //           message: error.response!.data[responseMessage],
  //         ),
  //       );
  //     }
  //   }
  // }
}
