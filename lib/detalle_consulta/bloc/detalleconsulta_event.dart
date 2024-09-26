part of 'detalleconsulta_bloc.dart';

abstract class DetalleconsultaEvent extends Equatable {
  const DetalleconsultaEvent();

  @override
  List<Object> get props => [];
}

final class CitasListShown extends DetalleconsultaEvent {}

final class EmpleadosListShown extends DetalleconsultaEvent {}

final class ConsultaSaved extends DetalleconsultaEvent {
  final int idcita;
  final int idempleado;
  final String sintomas;
  final String diagnostico;

  const ConsultaSaved({
    required this.idcita,
    required this.idempleado,
    required this.sintomas,
    required this.diagnostico,
  });
}

final class ConsultaEdited extends DetalleconsultaEvent {
  final int idconsulta;
  final int idcita;
  final int idempleado;
  final String sintomas;
  final String diagnostico;

  const ConsultaEdited({
    required this.idconsulta,
    required this.idcita,
    required this.idempleado,
    required this.sintomas,
    required this.diagnostico,
  });
}
