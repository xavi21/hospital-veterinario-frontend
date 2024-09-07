import 'dart:async';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/opciones/model/opciones_list_model.dart';
import 'package:paraiso_canino/opciones/service/opciones_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'opciones_event.dart';
part 'opciones_state.dart';

class OpcionesBloc extends Bloc<OpcionesEvent, OpcionesState> {
  OpcionesBloc() : super(OpcionesInitial()) {
    on<OptionsShown>(getOptionList);
    on<OptionCreated>(createOption);
    on<OptionEdited>(updateOption);
    on<OptionDeleted>(deleteOption);
  }

  final OpcionesService service = OpcionesService();

  Future<void> getOptionList(
    OptionsShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionesInProgress(),
    );
    try {
      final List<OpcionesListModel> response = await service.getOptions();
      emit(
        OpcionesListSuccess(
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
          OpcionesServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createOption(
    OptionCreated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionesInProgress(),
    );
    try {
      await service.addNewOption(
        name: event.name,
        orderMenu: event.orderMenu,
        pagina: event.page,
      );
      emit(
        OpcionesAddNewSuccess(),
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
          OpcionesServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateOption(
    OptionEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionesInProgress(),
    );
    try {
      await service.updateOption(
        idOpcion: event.id,
        name: event.name,
        orderMenu: event.orderMenu,
        pagina: event.page,
      );
      emit(
        OpcionesEditedSuccess(),
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
          OpcionesServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteOption(
    OptionDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      OpcionesInProgress(),
    );
    try {
      await service.deleteOption(
        id: event.id,
      );
      emit(
        OpcionesDeletedSuccess(),
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
          OpcionesServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }
}
