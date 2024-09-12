part of 'consulta_bloc.dart';

abstract class ConsultaState extends BaseState {}

final class ConsultaInitial extends ConsultaState {}

final class ConsultaInProgress extends ConsultaState {}

final class ConsultaSuccess extends ConsultaState {
  final List<ConsultaListModel> consultas;

  ConsultaSuccess({
    required this.consultas,
  });
}

final class ConsultaCreatedSuccess extends ConsultaState {}

final class ConsultaEditedSuccess extends ConsultaState {}

final class ConsultaDeletedSuccess extends ConsultaState {}

final class ConsultaError extends ConsultaState {
  final String message;

  ConsultaError({
    required this.message,
  });
}
