part of 'casamedica_bloc.dart';

abstract class CasamedicaEvent extends Equatable {
  const CasamedicaEvent();

  @override
  List<Object> get props => [];
}

final class CasaMedicaShown extends CasamedicaEvent {}

final class CasaMedicaSaved extends CasamedicaEvent {
  final String name;
  final String nombreComercial;

  const CasaMedicaSaved({
    required this.name,
    required this.nombreComercial,
  });
}

final class CasaMedicaEdited extends CasamedicaEvent {
  final int id;
  final String name;
  final String nombreComercial;

  const CasaMedicaEdited({
    required this.id,
    required this.name,
    required this.nombreComercial,
  });
}

final class CasaMedicaDeleted extends CasamedicaEvent {
  final int id;

  const CasaMedicaDeleted({
    required this.id,
  });
}
