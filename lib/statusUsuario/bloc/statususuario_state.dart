part of 'statususuario_bloc.dart';

abstract class StatususuarioState extends BaseState {}

class StatususuarioInitial extends StatususuarioState {}

final class StatusUsuarioInProgress extends StatususuarioState {}

final class StatusUsuarioSuccess extends StatususuarioState {
  final List<StatusUsuarioListModel> statusUsuarios;

  StatusUsuarioSuccess({
    required this.statusUsuarios,
  });
}

final class StatusUsuarioCreatedSuccess extends StatususuarioState {}

final class StatusUsuarioEditedSuccess extends StatususuarioState {}

final class StatusUsuarioDeletedSuccess extends StatususuarioState {}

final class StatusUsuarioError extends StatususuarioState {
  final String message;

  StatusUsuarioError({
    required this.message,
  });
}
