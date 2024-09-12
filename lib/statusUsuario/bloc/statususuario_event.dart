part of 'statususuario_bloc.dart';

abstract class StatususuarioEvent extends Equatable {
  const StatususuarioEvent();

  @override
  List<Object> get props => [];
}

final class StatusUsuarioShown extends StatususuarioEvent {}

final class StatusUsuarioSaved extends StatususuarioEvent {
  final String name;

  const StatusUsuarioSaved({
    required this.name,
  });
}

final class StatusUsuarioEdited extends StatususuarioEvent {
  final int id;
  final String name;

  const StatusUsuarioEdited({
    required this.id,
    required this.name,
  });
}

final class StatusUsuarioDeleted extends StatususuarioEvent {
  final int statusUsuarioId;

  const StatusUsuarioDeleted({
    required this.statusUsuarioId,
  });
}
