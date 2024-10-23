import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/cliente/model/cliente_response.dart';
import 'package:paraiso_canino/cliente/service/cliente_service.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(ClienteInitial()) {
    on<ClienteShown>(getClientes);
    on<ClienteSaved>(createCliente);
    on<ClienteEdited>(updateCliente);
    on<ClienteDeleted>(deleteCliente);
  }

  final ClienteService service = ClienteService();

  Future<void> getClientes(
    ClienteShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ClienteInProgress(),
    );
    try {
      final List<ClienteListModel> resp = await service.getClientes();
      emit(
        ClienteSuccess(clientes: resp),
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
          ClienteError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createCliente(
    ClienteSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ClienteInProgress(),
    );
    try {
      await service.createCliente(
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
        ClienteCreatedSuccess(),
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
          ClienteError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateCliente(
    ClienteEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ClienteInProgress(),
    );
    try {
      await service.updateCliente(
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
        ClienteEditedSuccess(),
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
          ClienteError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteCliente(
    ClienteDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ClienteInProgress(),
    );
    try {
      await service.deleteCliente(
        id: event.clienteID,
      );
      emit(
        ClienteDeletedSuccess(),
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
          ClienteError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
