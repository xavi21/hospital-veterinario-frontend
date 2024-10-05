import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/hospitalizacion_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/model/medicina_list_model.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/service/hospitalizacion_memdicamento_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'hospitalizacionmedicamento_event.dart';
part 'hospitalizacionmedicamento_state.dart';

class HospitalizacionmedicamentoBloc extends Bloc<
    HospitalizacionmedicamentoEvent, HospitalizacionmedicamentoState> {
  HospitalizacionmedicamentoBloc()
      : super(HospitalizacionmedicamentoInitial()) {
    on<MedicinasListShown>(getMedicinas);
    on<HospitalizacionShown>(getHospitalizacion);
    on<HospitalizacionSaved>(saveHospitalizacion);
    on<HospitalizacionUpdated>(updateHospitalizacion);
  }

  final HospitalizacionMemdicamentoService service =
      HospitalizacionMemdicamentoService();

  Future<void> getMedicinas(
    MedicinasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionInProgress(),
    );
    try {
      final List<MedicinaListModel> resp = await service.getMedicinas();
      emit(
        MedicinasListSuccess(
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
          HospitalizacionError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getHospitalizacion(
    HospitalizacionShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionInProgress(),
    );
    try {
      final response = await service.getHospitalizacionById(
        idHospitalizacion: event.idhospitalizacion,
      );
      emit(
        HospitalizacionListSuccess(
          hospitalizaciones: response,
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
          HospitalizacionError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> saveHospitalizacion(
    HospitalizacionSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionInProgress(),
    );
    try {
      await service.newHospitalizacion(
        idHospitalizacion: event.idhospitalizacion,
        idMedicamento: event.idMedicamento,
        observaciones: event.observaciones,
      );
      emit(
        HospitalCreatedSuccess(),
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
          HospitalizacionError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateHospitalizacion(
    HospitalizacionUpdated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionInProgress(),
    );
    try {
      await service.newHospitalizacion(
        idHospitalizacion: event.idhospitalizacion,
        idMedicamento: event.idMedicamento,
        observaciones: event.observaciones,
      );
      emit(
        HospitalEditedSuccess(),
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
          HospitalizacionError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
