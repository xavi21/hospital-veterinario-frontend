part of 'hospitalizacionmedicamento_bloc.dart';

abstract class HospitalizacionmedicamentoEvent extends Equatable {
  const HospitalizacionmedicamentoEvent();

  @override
  List<Object> get props => [];
}

final class HospitalizacionShown extends HospitalizacionmedicamentoEvent {
  final int idhospitalizacion;

  const HospitalizacionShown({
    required this.idhospitalizacion,
  });
}

final class MedicinasListShown extends HospitalizacionmedicamentoEvent {}

final class HospitalizacionSaved extends HospitalizacionmedicamentoEvent {
  final int idhospitalizacion;
  final int idMedicamento;
  final String observaciones;

  const HospitalizacionSaved({
    required this.idhospitalizacion,
    required this.idMedicamento,
    required this.observaciones,
  });
}

final class HospitalizacionUpdated extends HospitalizacionmedicamentoEvent {
  final int idhospitalizacionmedicamento;
  final int idhospitalizacion;
  final int idMedicamento;
  final String observaciones;

  const HospitalizacionUpdated({
    required this.idhospitalizacionmedicamento,
    required this.idhospitalizacion,
    required this.idMedicamento,
    required this.observaciones,
  });
}
