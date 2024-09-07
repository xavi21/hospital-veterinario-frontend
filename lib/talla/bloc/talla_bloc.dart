import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/talla/model/talla_list_model.dart';
import 'package:paraiso_canino/talla/service/talla_service.dart';

part 'talla_event.dart';
part 'talla_state.dart';

class TallaBloc extends Bloc<TallaEvent, TallaState> {
  TallaBloc() : super(TallaInitial()) {
    on<TallaShown>(getTalla);
    on<TallaSaved>(createTalla);
    on<TallaEdited>(updateTalla);
    on<TallaDeleted>(deleteTalla);
  }
  final TallaService service = TallaService();

  Future<void> getTalla(
    TallaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TallaInProgress(),
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
          TallaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createTalla(
    TallaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TallaInProgress(),
    );
    try {
      await service.createTalla(
        name: event.name,
      );
      emit(
        TallaCreatedSuccess(),
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
          TallaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateTalla(
    TallaEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TallaInProgress(),
    );
    try {
      await service.updateTalla(
        id: event.id,
        name: event.name,
      );
      emit(
        TallaEditedSuccess(),
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
          TallaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteTalla(
    TallaDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      TallaInProgress(),
    );
    try {
      await service.deleteTalla(
        id: event.tallaID,
      );
      emit(
        TallaDeletedSuccess(),
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
          TallaError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
