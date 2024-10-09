part of 'genero_bloc.dart';

abstract class GeneroState extends BaseState {}

final class GeneroInitial extends GeneroState {}

final class GeneroInProgress extends GeneroState {}

final class GeneroSuccess extends GeneroState {
  final List<GeneroListModel> genero;

  GeneroSuccess({
    required this.genero,
  });
}

final class GeneroDeletedSuccess extends GeneroState {}

final class GeneroError extends GeneroState {
  final String message;

  GeneroError({
    required this.message,
  });
}
