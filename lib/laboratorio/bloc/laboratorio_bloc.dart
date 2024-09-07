import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/laboratorio/model/laboratorio_list_model.dart';
import 'package:paraiso_canino/laboratorio/service/laboratorio_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'laboratorio_event.dart';
part 'laboratorio_state.dart';

class LaboratorioBloc extends Bloc<LaboratorioEvent, LaboratorioState> {
  LaboratorioBloc() : super(LaboratorioInitial()) {
    on<LaboratorioShown>(getLaboratorios);
    on<LaboratorioSaved>(createLaboratorio);
    on<LaboratorioEdited>(updateLaboratorio);
    on<LaboratorioDeleted>(deleteLaboratorio);
  }

  final LaboratorioService service = LaboratorioService();

  Future<void> getLaboratorios(
    LaboratorioShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LaboratorioInProgress(),
    );
    try {
      final List<LaboratorioListModel> resp = await service.getLaboratorios();
      emit(
        LaboratorioSuccess(laboratorios: resp),
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
          LaboratorioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createLaboratorio(
    LaboratorioSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LaboratorioInProgress(),
    );
    try {
      await service.createLaboratorio(
        name: event.name,
        descripcion: event.descripcion,
      );
      emit(
        LaboratorioCreatedSuccess(),
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
          LaboratorioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateLaboratorio(
    LaboratorioEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LaboratorioInProgress(),
    );
    try {
      await service.updateLaboratorio(
        id: event.id,
        name: event.name,
        descripcion: event.descripcion,
      );
      emit(
        LaboratorioEditedSuccess(),
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
          LaboratorioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteLaboratorio(
    LaboratorioDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LaboratorioInProgress(),
    );
    try {
      await service.deleteLaboratorio(
        id: event.laboratorioId,
      );
      emit(
        LaboratorioDeletedSuccess(),
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
          LaboratorioError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
