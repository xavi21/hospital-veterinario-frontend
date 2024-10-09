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
