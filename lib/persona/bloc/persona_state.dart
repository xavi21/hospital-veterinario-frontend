part of 'persona_bloc.dart';

abstract class PersonaState extends BaseState {}

final class PersonaInitial extends PersonaState {}

final class PersonaInProgress extends PersonaState {}

final class PersonaSuccess extends PersonaState {
  final List<PersonaListModel> personas;

  PersonaSuccess({
    required this.personas,
  });
}

final class PersonaCreatedSuccess extends PersonaState {}

final class PersonaEditedSuccess extends PersonaState {}

final class PersonaDeletedSuccess extends PersonaState {}

final class PersonaError extends PersonaState {
  final String message;

  PersonaError({
    required this.message,
  });
}
