part of 'grooming_bloc.dart';

abstract class GroomingEvent extends Equatable {
  const GroomingEvent();

  @override
  List<Object> get props => [];
}

final class GroomingShown extends GroomingEvent {}

final class CitasListShown extends GroomingEvent {}

final class EmpleadosListShown extends GroomingEvent {}

final class GroomingSaved extends GroomingEvent {
  final int idcita;
  final int idempleado;

  const GroomingSaved({
    required this.idcita,
    required this.idempleado,
  });
}

final class GroomingEdited extends GroomingEvent {
  final int idGrooming;
  final int idcita;
  final int idempleado;

  const GroomingEdited({
    required this.idGrooming,
    required this.idcita,
    required this.idempleado,
  });
}
