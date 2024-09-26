part of 'detalleconsulta_bloc.dart';

abstract class DetalleconsultaState extends BaseState {}

final class DetalleconsultaInitial extends DetalleconsultaState {}

final class DetalleconsultaInProgress extends DetalleconsultaState {}

final class ConsultaCreatedSuccess extends DetalleconsultaState {
  final int idConsulta;

  ConsultaCreatedSuccess({
    required this.idConsulta,
  });
}

final class ConsultaEditedSuccess extends DetalleconsultaState {}

final class DetalleconsultaCitaListSuccess extends DetalleconsultaState {
  final List<CitaModel> citas;

  DetalleconsultaCitaListSuccess({
    required this.citas,
  });
}

final class DetalleconsultaEmpleadoListSuccess extends DetalleconsultaState {
  final List<EmpleadoModel> empleados;

  DetalleconsultaEmpleadoListSuccess({
    required this.empleados,
  });
}

final class DetalleconsultaServiceError extends DetalleconsultaState {
  final String message;

  DetalleconsultaServiceError({
    required this.message,
  });
}
