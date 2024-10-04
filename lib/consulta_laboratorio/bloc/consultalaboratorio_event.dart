part of 'consultalaboratorio_bloc.dart';

abstract class ConsultalaboratorioEvent extends Equatable {
  const ConsultalaboratorioEvent();

  @override
  List<Object> get props => [];
}

final class LaboratorioShown extends ConsultalaboratorioEvent {}

final class LaboratorioByConsultaShown extends ConsultalaboratorioEvent {
  final int idConsulta;

  const LaboratorioByConsultaShown({
    required this.idConsulta,
  });
}

final class LaboratorioCreated extends ConsultalaboratorioEvent {
  final int idconsulta;
  final int idlaboratorio;
  final String resultado;
  final String fechasolicitud;
  final String fecharesultado;

  const LaboratorioCreated({
    required this.idconsulta,
    required this.idlaboratorio,
    required this.resultado,
    required this.fechasolicitud,
    required this.fecharesultado,
  });
}
