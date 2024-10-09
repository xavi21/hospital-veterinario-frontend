import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/genero/model/genero_response.dart';
import 'package:paraiso_canino/genero/service/genero_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'genero_event.dart';
part 'genero_state.dart';

class GeneroBloc extends Bloc<GeneroEvent, GeneroState> {
  GeneroBloc() : super(GeneroInitial()) {
    on<GeneroShown>(getGenero);
    on<GeneroDeleted>(deleteGenero);
  }

  final GeneroService service = GeneroService();

  Future<void> getGenero(
    GeneroShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GeneroInProgress(),
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
          GeneroError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteGenero(
    GeneroDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GeneroInProgress(),
    );
    try {
      await service.deleteGenero(
        id: event.generoID,
      );
      emit(
        GeneroDeletedSuccess(),
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
          GeneroError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
