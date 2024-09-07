part of 'laboratorio_bloc.dart';

abstract class LaboratorioEvent extends Equatable {
  const LaboratorioEvent();

  @override
  List<Object> get props => [];
}

final class LaboratorioShown extends LaboratorioEvent {}

final class LaboratorioSaved extends LaboratorioEvent {
  final String name;
  final String descripcion;

  const LaboratorioSaved({
    required this.name,
    required this.descripcion,
  });
}

final class LaboratorioEdited extends LaboratorioEvent {
  final int id;
  final String name;
  final String descripcion;

  const LaboratorioEdited({
    required this.id,
    required this.name,
    required this.descripcion,
  });
}

final class LaboratorioDeleted extends LaboratorioEvent {
  final int laboratorioId;

  const LaboratorioDeleted({
    required this.laboratorioId,
  });
}
