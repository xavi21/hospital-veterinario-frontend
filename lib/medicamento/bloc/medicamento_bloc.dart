import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/medicamento/model/medicamento_response.dart';
import 'package:paraiso_canino/medicamento/service/medicamento_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'medicamento_event.dart';
part 'medicamento_state.dart';

class MedicamentoBloc extends Bloc<MedicamentoEvent, MedicamentoState> {
  MedicamentoBloc() : super(MedicamentoInitial()) {
    on<MedicamentoShown>(getMedicamentos);
    on<MedicamentoDeleted>(deleteMedicamento);
  }

  final MedicamentoService service = MedicamentoService();

  Future<void> getMedicamentos(
    MedicamentoShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      final List<MedicamentoListModel> resp = await service.getMedicamentos();
      emit(
        MedicamentoSuccess(medicamentos: resp),
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
          MedicamentoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteMedicamento(
    MedicamentoDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      await service.deleteMedicamento(
        id: event.medicamentoID,
      );
      emit(
        MedicamentoDeletedSuccess(),
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
          MedicamentoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
