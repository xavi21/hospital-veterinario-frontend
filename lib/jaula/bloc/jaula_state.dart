part of 'jaula_bloc.dart';

abstract class JaulaState extends BaseState {}

final class JaulaInitial extends JaulaState {}

final class JaulaInProgress extends JaulaState {}

final class JaulaSuccess extends JaulaState {
  final List<JaulaListModel> jaulas;

  JaulaSuccess({
    required this.jaulas,
  });
}

final class JaulaCreatedSuccess extends JaulaState {}

final class JaulaEditedSuccess extends JaulaState {}

final class JaulaDeletedSuccess extends JaulaState {}

final class JaulaError extends JaulaState {
  final String message;

  JaulaError({
    required this.message,
  });
}
