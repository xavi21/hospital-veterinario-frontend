part of 'opciones_bloc.dart';

abstract class OpcionesState extends BaseState {}

final class OpcionesInitial extends OpcionesState {}

final class OpcionesInProgress extends OpcionesState {}

final class OpcionesListSuccess extends OpcionesState {
  final List<OpcionesListModel> optionList;

  OpcionesListSuccess({
    required this.optionList,
  });
}

final class OpcionesAddNewSuccess extends OpcionesState {
  final String message;

  OpcionesAddNewSuccess({
    required this.message,
  });
}

final class OpcionesServiceError extends OpcionesState {
  final String message;

  OpcionesServiceError({
    required this.message,
  });
}
