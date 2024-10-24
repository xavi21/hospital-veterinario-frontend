import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/empleado/model/empleado_model.dart';
import 'package:paraiso_canino/empleado/service/empleado_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'empleado_event.dart';
part 'empleado_state.dart';

class EmpleadoBloc extends Bloc<EmpleadoEvent, EmpleadoState> {
  EmpleadoBloc() : super(EmpleadoInitial()) {
    on<EmpleadoShown>(getEmpleados);
    on<EmpleadoSaved>(createEmpleado);
    on<EmpleadoEdited>(updateEmpleado);
    on<EmpleadoDeleted>(deleteEmpleado);
  }

  final EmpleadoService service = EmpleadoService();

  Future<void> getEmpleados(
    EmpleadoShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EmpleadoInProgress(),
    );
    try {
      final List<EmpleadoListModel> resp = await service.getEmpleados();
      emit(
        EmpleadoSuccess(empleados: resp),
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
          EmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createEmpleado(
    EmpleadoSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EmpleadoInProgress(),
    );
    try {
      await service.createEmpleado(
        name: event.name,
        lastName: event.lastName,
        birthDate: event.birthDate,
        contractDate: event.contractDate,
        idSucursal: event.idSucursal,
        idPuesto: event.idPuesto,
        idEstadoCivil: event.idEstadoCivil,
        idGenero: event.idGenero,
        idStatusEmpleado: event.idStatusEmpleado,
      );
      emit(
        EmpleadoCreatedSuccess(),
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
          EmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateEmpleado(
    EmpleadoEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EmpleadoInProgress(),
    );
    try {
      await service.updateEmpleado(
        id: event.id,
        name: event.name,
        lastName: event.lastName,
        birthDate: event.birthDate,
        contractDate: event.contractDate,
        idSucursal: event.idSucursal,
        idPuesto: event.idPuesto,
        idEstadoCivil: event.idEstadoCivil,
        idGenero: event.idGenero,
        idStatusEmpleado: event.idStatusEmpleado,
      );
      emit(
        EmpleadoEditedSuccess(),
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
          EmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteEmpleado(
    EmpleadoDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EmpleadoInProgress(),
    );
    try {
      await service.deleteEmpleado(
        id: event.id,
      );
      emit(
        EmpleadoDeletedSuccess(),
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
          EmpleadoError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
