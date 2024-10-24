import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/medicamento/model/casa_medica_model.dart';
import 'package:paraiso_canino/medicamento/model/componente_principal_model.dart';
import 'package:paraiso_canino/medicamento/model/medicamento_response.dart';
import 'package:paraiso_canino/medicamento/service/medicamento_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'medicamento_event.dart';
part 'medicamento_state.dart';

class MedicamentoBloc extends Bloc<MedicamentoEvent, MedicamentoState> {
  MedicamentoBloc() : super(MedicamentoInitial()) {
    on<MedicamentoShown>(getMedicamentos);
    on<CasaMedicaShown>(getCasaMedicas);
    on<ComponentePrincipalShown>(getComponentePrincipal);
    on<MedicamentoSaved>(createMedicamento);
    on<MedicamentoUpdated>(updateMedicamento);
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

  Future<void> getCasaMedicas(
    CasaMedicaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      final List<CasaMedicaListModel> resp = await service.getCasaMedicas();
      emit(
        CasaMedicaSuccess(casasMedicas: resp),
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

  Future<void> getComponentePrincipal(
    ComponentePrincipalShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      final List<ComponentePrincipalListModel> resp =
          await service.getComponentePrincipal();
      emit(
        ComponentePrincipalSuccess(componentePrincipal: resp),
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

  Future<void> createMedicamento(
    MedicamentoSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      await service.createMedicamento(
        name: event.name,
        description: event.description,
        idCasaMeidca: event.idCasaMeidca,
        idComponentePrincipal: event.idComponentePrincipal,
      );
      emit(
        MedicamentoCreatedSuccess(),
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

  Future<void> updateMedicamento(
    MedicamentoUpdated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MedicamentoInProgress(),
    );
    try {
      await service.updateMedicamento(
        id: event.id,
        name: event.name,
        description: event.description,
        idCasaMeidca: event.idCasaMeidca,
        idComponentePrincipal: event.idComponentePrincipal,
      );
      emit(
        MedicamentoUpdatedSuccess(),
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
