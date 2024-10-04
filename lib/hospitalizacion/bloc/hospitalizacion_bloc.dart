import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/hospitalizacion/model/hotpitalizacion_list_model.dart';
import 'package:paraiso_canino/hospitalizacion/service/hospitalizacion_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'hospitalizacion_event.dart';
part 'hospitalizacion_state.dart';

class HospitalizacionBloc
    extends Bloc<HospitalizacionEvent, HospitalizacionState> {
  HospitalizacionBloc() : super(HospitalizacionInitial()) {
    on<HospitalizacionShown>(getHospitalizaciones);
  }

  final HospitalizacionService service = HospitalizacionService();

  Future<void> getHospitalizaciones(
    HospitalizacionShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HospitalizacionInProgress(),
    );
    try {
      final List<HospitalizacionListModel> resp =
          await service.getHospitalizaciones();
      emit(
        HospitalizacionSuccess(hospitalizaciones: resp),
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
