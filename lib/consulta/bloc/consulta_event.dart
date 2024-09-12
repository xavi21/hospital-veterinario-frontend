part of 'consulta_bloc.dart';

abstract class ConsultaEvent extends Equatable {
  const ConsultaEvent();

  @override
  List<Object> get props => [];
}

final class ConsultaShown extends ConsultaEvent {}

final class ConsultaSaved extends ConsultaEvent {
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

final class ConsultaEdited extends ConsultaEvent {
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

final class ConsultaDeleted extends ConsultaEvent {
  final int consultaID;

  const ConsultaDeleted({
    required this.consultaID,
  });
}
