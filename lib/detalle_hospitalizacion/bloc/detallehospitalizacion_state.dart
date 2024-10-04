part of 'detallehospitalizacion_bloc.dart';

abstract class DetallehospitalizacionState extends BaseState {}

class DetallehospitalizacionInitial extends DetallehospitalizacionState {}

final class DetalleHospitalizacionInProgress
    extends DetallehospitalizacionState {}

final class HospitalizacionCreatedSuccess extends DetallehospitalizacionState {
  final int idHospitalizacion;

  HospitalizacionCreatedSuccess({
    required this.idHospitalizacion,
  });
}

final class HospitalizacionMascotaSuccess extends DetallehospitalizacionState {
  final List<MascotaModel> mascotas;

  HospitalizacionMascotaSuccess({
    required this.mascotas,
  });
}

final class HospitalizacionEditedSuccess extends DetallehospitalizacionState {}

final class DetalleHospitalizacionJaulaListSuccess
    extends DetallehospitalizacionState {
  final List<JaulaModel> jaulas;

  DetalleHospitalizacionJaulaListSuccess({
    required this.jaulas,
  });
}

final class DetalleHospitalizacionServiceError
    extends DetallehospitalizacionState {
  final String message;

  DetalleHospitalizacionServiceError({
    required this.message,
  });
}
