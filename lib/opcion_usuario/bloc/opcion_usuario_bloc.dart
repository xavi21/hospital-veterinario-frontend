import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/opcion_usuario/service/opcion_usuario_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'opcion_usuario_event.dart';
part 'opcion_usuario_state.dart';

class OpcionUsuarioBloc extends Bloc<OpcionUsuarioEvent, OpcionUsuarioState> {
  OpcionUsuarioBloc() : super(OpcionUsuarioInitial()) {
    on<UserOptionsShown>(getOptionList);
  }

  OpcioneUsuarioService service = OpcioneUsuarioService();

  Future<void> getOptionList(
    UserOptionsShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      final List<OpcionUsuarioModel> response = await service.getOptions();
      emit(
        OpcionUsuarioListSuccess(
          opcionesList: response,
        ),
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
          OpcionUsuarioServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }
}
