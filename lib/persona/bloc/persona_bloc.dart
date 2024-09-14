import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/persona/model/persona_list_model.dart';
import 'package:paraiso_canino/persona/service/persona_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'persona_event.dart';
part 'persona_state.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {
  PersonaBloc() : super(PersonaInitial()) {
    on<PersonaShown>(getPersona);
    on<PersonaSaved>(createPersona);
    on<PersonaEdited>(updatePersona);
    on<PersonaDeleted>(deletePersona);
  }

  final PersonaService service = PersonaService();

  Future<void> getPersona(
    PersonaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PersonaInProgress(),
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
          PersonaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createPersona(
    PersonaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PersonaInProgress(),
    );
    try {
      await service.createPersona(
        nombre: event.nombre,
        apellido: event.apellido,
        fechaNacimiento: event.fechaNacimiento,
        idGenero: event.idGenero,
        direccion: event.direccion,
        telefono: event.telefono,
        correoElectronico: event.correoElectronico,
        idEstadoCivil: event.idEstadoCivil,
      );
      emit(
        PersonaCreatedSuccess(),
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
          PersonaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updatePersona(
    PersonaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PersonaInProgress(),
    );
    try {
      await service.updatePersona(
        fechacreacion: event.fechacreacion,
        usuariocreacion: event.usuariocreacion,
        fechamodificacion: event.fechamodificacion,
        usuariomodificacion: event.usuariomodificacion,
        idpersona: event.idpersona,
        nombre: event.nombre,
        apellido: event.apellido,
        fechanacimiento: event.fechanacimiento,
        idGenero: event.idGenero,
        direccion: event.direccion,
        telefono: event.telefono,
        correoelectronico: event.correoelectronico,
        idEstadoCivil: event.idEstadoCivil,
      );
      emit(
        PersonaEditedSuccess(),
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
          PersonaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deletePersona(
    PersonaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      PersonaInProgress(),
    );
    try {
      await service.deletePersona(
        id: event.id,
      );
      emit(
        PersonaDeletedSuccess(),
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
          PersonaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
