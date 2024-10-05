part of 'hospitalizacion_laboratorio_bloc.dart';

abstract class HospitalizacionLaboratorioEvent extends Equatable {
  const HospitalizacionLaboratorioEvent();

  @override
  List<Object> get props => [];
}

final class LaboratorioShown extends HospitalizacionLaboratorioEvent {}

final class LaboratorioByHospitalShown extends HospitalizacionLaboratorioEvent {
  final int idhospitalizacion;

  const LaboratorioByHospitalShown({
    required this.idhospitalizacion,
  });
}

final class LaboratorioCreated extends HospitalizacionLaboratorioEvent {
  final int idhospitalizacion;
  final int idlaboratorio;
  final String resultado;
  final String fechasolicitud;
  final String fecharesultado;

  const LaboratorioCreated({
    required this.idhospitalizacion,
    required this.idlaboratorio,
    required this.resultado,
    required this.fechasolicitud,
    required this.fecharesultado,
  });
}
