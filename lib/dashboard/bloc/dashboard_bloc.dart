import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/dashboard/model/consulta_response.dart';
import 'package:paraiso_canino/dashboard/model/grooming_list_model.dart';
import 'package:paraiso_canino/dashboard/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/dashboard/model/mascota_list_model.dart';
import 'package:paraiso_canino/dashboard/service/dashboard_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<ConsultaShown>(getConsultas);
    on<GroomingShown>(getGroomings);
    on<MascotaShown>(getMascotas);
    on<HospitalizacionShown>(getHospitalizaciones);
  }

  final DashboardService service = DashboardService();

  Future<void> getConsultas(
    ConsultaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DashboardInProgress(),
    );
    try {
      final List<ConsultaListModel> resp = await service.getConsultas();
      emit(
        DashboardConsultaSuccess(consultas: resp),
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
          DashboardServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getGroomings(
    GroomingShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DashboardInProgress(),
    );
    try {
      final List<GroomingListModel> resp = await service.getGrooming();
      emit(
        DashboardGroomingSuccess(groomings: resp),
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
          DashboardServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getMascotas(
    MascotaShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DashboardInProgress(),
    );
    try {
      final List<MascotaListModel> resp = await service.getMascotas();
      emit(
        DashboardMascotaSuccess(mascotas: resp),
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
          DashboardServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getHospitalizaciones(
    HospitalizacionShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      DashboardInProgress(),
    );
    try {
      final List<HospitalizacionListModel> resp =
          await service.getHospitalizaciones();
      emit(
        DashboardHospitalizacionSuccess(hospitalizaciones: resp),
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
          DashboardServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
