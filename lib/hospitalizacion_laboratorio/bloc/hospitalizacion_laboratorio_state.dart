part of 'hospitalizacion_laboratorio_bloc.dart';

abstract class HospitalizacionLaboratorioState extends BaseState {}

class HospitalizacionLaboratorioInitial
    extends HospitalizacionLaboratorioState {}

class HospitalizacionLaboratorioInProgress
    extends HospitalizacionLaboratorioState {}

class LaboratorioCreatedSuccess extends HospitalizacionLaboratorioState {}

class HospitalizacionLaboratorioListSuccess
    extends HospitalizacionLaboratorioState {
  final List<LaboratorioListModel> laboratorios;

  HospitalizacionLaboratorioListSuccess({
    required this.laboratorios,
  });
}

class HospitalizacionLaboratorioByConsultaSuccess
    extends HospitalizacionLaboratorioState {
  final List<LabHospitalListModel> laboratorios;

  HospitalizacionLaboratorioByConsultaSuccess({
    required this.laboratorios,
  });
}

class HospitalizacionLaboratorioServiceError
    extends HospitalizacionLaboratorioState {
  final String message;

  HospitalizacionLaboratorioServiceError({
    required this.message,
  });
}
