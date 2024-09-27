part of 'consultalaboratorio_bloc.dart';

abstract class ConsultalaboratorioState extends BaseState {}

class ConsultalaboratorioInitial extends ConsultalaboratorioState {}

class ConsultalaboratorioInProgress extends ConsultalaboratorioState {}

class ConsultalaboratorioListSuccess extends ConsultalaboratorioState {
  final List<LaboratorioListModel> laboratorios;

  ConsultalaboratorioListSuccess({
    required this.laboratorios,
  });
}

class ConsultalaboratorioServiceError extends ConsultalaboratorioState {
  final String message;

  ConsultalaboratorioServiceError({
    required this.message,
  });
}
