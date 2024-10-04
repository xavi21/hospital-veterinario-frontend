import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/receta/model/consulta_model.dart';
import 'package:paraiso_canino/receta/model/medicina_list_model.dart';
import 'package:paraiso_canino/receta/model/receta_list_model.dart';
import 'package:paraiso_canino/receta/service/receta_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'receta_event.dart';
part 'receta_state.dart';

class RecetaBloc extends Bloc<RecetaEvent, RecetaState> {
  RecetaBloc() : super(RecetaInitial()) {
    on<MedicinasListShown>(getMedicinas);
    on<RecetaShown>(getReceta);
    on<RecetaSaved>(saveReceta);
    on<DetalleRecetaShown>(getDetalleRecetas);
    on<DetalleRecetaSaved>(saveDetalleReceta);
  }

  final RecetaService service = RecetaService();

  Future<void> getReceta(
    RecetaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecetaInProgress(),
    );
    try {
      final ConsultaModel response = await service.getConsulta(
        idConsulta: event.idconsulta,
      );
      emit(
        ConsultaSuccess(
          consulta: response,
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
          RecetaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getMedicinas(
    MedicinasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecetaInProgress(),
    );
    try {
      final List<MedicinaListModel> resp = await service.getMedicinas();
      emit(
        RecetaMedicinasListSuccess(
          medicinas: resp,
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
          RecetaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getDetalleRecetas(
    DetalleRecetaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecetaInProgress(),
    );
    try {
      final List<RecetaListModel> resp = await service.getDetalleRecetas(
        idReceta: event.idReceta,
      );
      emit(
        DetalleRecetasListSuccess(
          recetas: resp,
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
          RecetaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> saveReceta(
    RecetaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecetaInProgress(),
    );
    try {
      final resp = await service.newReceta(
        idConsulta: event.idconsulta,
        observaciones: event.observaciones,
      );
      emit(
        RecetaCreatedSuccess(
          idReceta: resp.data['data']['idreceta'],
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
          RecetaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> saveDetalleReceta(
    DetalleRecetaSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecetaInProgress(),
    );
    try {
      await service.newDetalleReceta(
        cantidad: event.cantidad,
        idReceta: event.idReceta,
        idMedicamento: event.idMedicamento,
        indicaciones: event.indicaciones,
      );
      emit(
        DetalleRecetaCreatedSuccess(),
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
          RecetaServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
