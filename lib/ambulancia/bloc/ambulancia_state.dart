part of 'ambulancia_bloc.dart';

abstract class AmbulanciaState extends BaseState {}

final class AmbulanciaInitial extends AmbulanciaState {}

final class AmbulanciaInProgress extends AmbulanciaState {}

final class AmbulanciaListSuccess extends AmbulanciaState {
  final List<AmbulanciaListModel> ambulancias;

  AmbulanciaListSuccess({
    required this.ambulancias,
  });
}

final class AmbulanciaCreatedSuccess extends AmbulanciaState {}

final class AmbulanciaEditedSuccess extends AmbulanciaState {}

final class AmbulanciaDeletedSuccess extends AmbulanciaState {}

final class AmbulanciaServiceError extends AmbulanciaState {
  final String message;

  AmbulanciaServiceError({
    required this.message,
  });
}
