import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/grooming/model/cita_list_model.dart';
import 'package:paraiso_canino/grooming/model/empleado_list_model.dart';
import 'package:paraiso_canino/grooming/model/grooming_list_model.dart';
import 'package:paraiso_canino/grooming/service/grooming_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'grooming_event.dart';
part 'grooming_state.dart';

class GroomingBloc extends Bloc<GroomingEvent, GroomingState> {
  GroomingBloc() : super(GroomingInitial()) {
    on<CitasListShown>(getCitas);
    on<EmpleadosListShown>(getEmpleados);
    on<GroomingShown>(getGrooming);
    on<GroomingSaved>(createGrooming);
    on<GroomingEdited>(updateGrooming);
  }

  final GroomingService service = GroomingService();

  Future<void> getCitas(
    CitasListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GroomingInProgress(),
    );
    try {
      final List<CitaModel> resp = await service.getCitas();
      emit(
        GroomingCitaListSuccess(citas: resp),
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
          GroomingServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getEmpleados(
    EmpleadosListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GroomingInProgress(),
    );
    try {
      final List<EmpleadoModel> resp = await service.getEmpleados();
      emit(
        GroomingEmpleadoListSuccess(empleados: resp),
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
          GroomingServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getGrooming(
    GroomingShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GroomingInProgress(),
    );
    try {
      final List<GroomingListModel> resp = await service.getGrooming();
      emit(
        GroomingSuccess(groomings: resp),
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
          GroomingServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createGrooming(
    GroomingSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GroomingInProgress(),
    );
    try {
      await service.createGrooming(
        idCita: event.idcita,
        idEmpleado: event.idempleado,
      );
      emit(
        GroomingCreatedSuccess(),
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
          GroomingServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateGrooming(
    GroomingEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      GroomingInProgress(),
    );
    try {
      await service.updateGrooming(
        idGrooming: event.idGrooming,
        idCita: event.idcita,
        idEmpleado: event.idempleado,
      );
      emit(
        GroomingEditedSuccess(),
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
          GroomingServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
