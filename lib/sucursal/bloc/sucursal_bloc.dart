import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';
import 'package:paraiso_canino/sucursal/model/sucursal_response.dart';
import 'package:paraiso_canino/sucursal/service/sucursal_service.dart';

part 'sucursal_event.dart';
part 'sucursal_state.dart';

class SucursalBloc extends Bloc<SucursalEvent, SucursalState> {
  SucursalBloc() : super(SucursalInitial()) {
    on<OfficeShown>(getOffices);
    on<OfficeSaved>(createOffice);
    on<OfficeEdited>(updateOffice);
    on<OfficeDeleted>(deleteOffice);
  }

  final SucursalService service = SucursalService();

  Future<void> getOffices(
    OfficeShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      SucursalInProgress(),
    );
    try {
      final List<OfficeListModel> resp = await service.getOffices();
      emit(
        SucursalSuccess(sucursales: resp),
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
          SucursalError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createOffice(
    OfficeSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      SucursalInProgress(),
    );
    try {
      await service.createOffice(
        name: event.name,
        direction: event.direction,
      );
      emit(
        SucursalCreatedSuccess(),
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
          SucursalError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateOffice(
    OfficeEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      SucursalInProgress(),
    );
    try {
      await service.updateOffice(
        id: event.id,
        name: event.name,
        direction: event.direction,
      );
      emit(
        SucursalEditedSuccess(),
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
          SucursalError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteOffice(
    OfficeDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      SucursalInProgress(),
    );
    try {
      await service.deleteOffice(
        id: event.officeID,
      );
      emit(
        SucursalDeletedSuccess(),
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
          SucursalError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
