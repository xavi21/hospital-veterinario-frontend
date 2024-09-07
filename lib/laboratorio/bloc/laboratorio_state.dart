part of 'laboratorio_bloc.dart';

abstract class LaboratorioState extends BaseState {}

final class LaboratorioInitial extends LaboratorioState {}

final class LaboratorioInProgress extends LaboratorioState {}

final class LaboratorioSuccess extends LaboratorioState {
  final List<LaboratorioListModel> laboratorios;

  LaboratorioSuccess({
    required this.laboratorios,
  });
}

final class LaboratorioCreatedSuccess extends LaboratorioState {}

final class LaboratorioEditedSuccess extends LaboratorioState {}

final class LaboratorioDeletedSuccess extends LaboratorioState {}

final class LaboratorioError extends LaboratorioState {
  final String message;

  LaboratorioError({
    required this.message,
  });
}
