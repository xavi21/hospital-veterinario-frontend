part of 'jaula_bloc.dart';

abstract class JaulaEvent extends Equatable {
  const JaulaEvent();

  @override
  List<Object> get props => [];
}

final class JaulaShown extends JaulaEvent {}

final class JaulaSaved extends JaulaEvent {
  final String descripcion;

  const JaulaSaved({
    required this.descripcion,
  });
}

final class JaulaEdited extends JaulaEvent {
  final int idJaula;
  final String descripcion;

  const JaulaEdited({
    required this.idJaula,
    required this.descripcion,
  });
}

final class JaulaDeleted extends JaulaEvent {
  final int jaulaID;

  const JaulaDeleted({
    required this.jaulaID,
  });
}
