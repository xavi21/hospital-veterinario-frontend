import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/jaula/model/jaula_list_model.dart';
import 'package:paraiso_canino/jaula/service/jaula_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'jaula_event.dart';
part 'jaula_state.dart';

class JaulaBloc extends Bloc<JaulaEvent, JaulaState> {
  JaulaBloc() : super(JaulaInitial()) {
    on<JaulaShown>(getJaula);
    on<JaulaSaved>(createJaula);
    on<JaulaEdited>(updateJaula);
    on<JaulaDeleted>(deleteJaula);
  }
  final JaulaService service = JaulaService();

  Future<void> getJaula(
    JaulaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      JaulaInProgress(),
    );
    try {
      final List<JaulaListModel> resp = await service.getJaula();
      emit(
        JaulaSuccess(jaulas: resp),
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
          JaulaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createJaula(
    JaulaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      JaulaInProgress(),
    );
    try {
      await service.createJaula(
        descripcion: event.descripcion,
      );
      emit(
        JaulaCreatedSuccess(),
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
          JaulaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateJaula(
    JaulaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      JaulaInProgress(),
    );
    try {
      await service.updateJaula(
        idJaula: event.idJaula,
        descripcion: event.descripcion,
      );
      emit(
        JaulaEditedSuccess(),
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
          JaulaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteJaula(
    JaulaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      JaulaInProgress(),
    );
    try {
      await service.deleteJaula(
        id: event.jaulaID,
      );
      emit(
        JaulaDeletedSuccess(),
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
          JaulaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
