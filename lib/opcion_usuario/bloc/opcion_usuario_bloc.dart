import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/opcion_usuario/model/menu_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opcion_usuario_model.dart';
import 'package:paraiso_canino/opcion_usuario/model/opciones_list_model.dart';
import 'package:paraiso_canino/opcion_usuario/service/opcion_usuario_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'opcion_usuario_event.dart';
part 'opcion_usuario_state.dart';

class OpcionUsuarioBloc extends Bloc<OpcionUsuarioEvent, OpcionUsuarioState> {
  OpcionUsuarioBloc() : super(OpcionUsuarioInitial()) {
    on<UserOptionsShown>(getOptionList);
    on<UserOptionSaved>(createUserOption);
    on<UserOptionEdited>(updateUserOption);
    on<UserOptionDeleted>(deleteUserOption);
    on<OptionsListShown>(getOptionSelectList);
    on<MenuListShown>(getMenuSelectList);
  }

  OpcioneUsuarioService service = OpcioneUsuarioService();

  Future<void> getOptionSelectList(
    OptionsListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      final List<OpcionesListModel> response = await service.getOptionsList();
      emit(
        OptionsListSuccess(
          optionList: response,
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

  Future<void> getMenuSelectList(
    MenuListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      final List<MenuModel> resp = await service.getMenuList();
      emit(
        MenuListSuccess(
          menuList: resp,
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
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

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

  Future<void> createUserOption(
    UserOptionSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      await service.createUserOption(
        idUsuario: event.idUsuario,
        idMenu: event.idMenu,
        idOpcion: event.idOpcion,
        alta: event.alta,
        baja: event.baja,
        cambio: event.cambio,
      );
      emit(
        OpcionUsuarioCreatedSuccess(),
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

  Future<void> updateUserOption(
    UserOptionEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      await service.updateUserOption(
        idUsuario: event.idUsuario,
        idMenu: event.idMenu,
        idOpcion: event.idOpcion,
        alta: event.alta,
        baja: event.baja,
        cambio: event.cambio,
      );
      emit(
        OpcionUsuarioEditedSuccess(),
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

  Future<void> deleteUserOption(
    UserOptionDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionUsuarioInProgress(),
    );
    try {
      await service.deleteUserOption(
        idUsuario: event.idUsuario,
        idMenu: event.idMenu,
        idOpcion: event.idOpcion,
      );
      emit(
        OpcionUsuarioDeletedSuccess(),
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
