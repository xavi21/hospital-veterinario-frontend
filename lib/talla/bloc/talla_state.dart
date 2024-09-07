part of 'talla_bloc.dart';

abstract class TallaState extends BaseState {}

final class TallaInitial extends TallaState {}

final class TallaInProgress extends TallaState {}

final class TallaSuccess extends TallaState {
  final List<TallaListModel> tallas;

  TallaSuccess({
    required this.tallas,
  });
}

final class TallaCreatedSuccess extends TallaState {}

final class TallaEditedSuccess extends TallaState {}

final class TallaDeletedSuccess extends TallaState {}

final class TallaError extends TallaState {
  final String message;

  TallaError({
    required this.message,
  });
}
