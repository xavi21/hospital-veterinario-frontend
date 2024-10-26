import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/usuario/model/usuario_list_model.dart';
import 'package:paraiso_canino/usuario/service/usuario_service.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  UsuarioBloc() : super(UsuarioInitial()) {
    on<UsuarioShown>(getUsuario);
  }

  final UsuarioService service = UsuarioService();

  Future<void> getUsuario(
    UsuarioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      UsuarioInProgress(),
    );
    try {
      final List<UsuarioListModel> resp = await service.getUsuario();
      emit(
        UsuarioSuccess(usuarios: resp),
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
          UsuarioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
