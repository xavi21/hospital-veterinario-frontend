part of 'medicamento_bloc.dart';

abstract class MedicamentoEvent extends Equatable {
  const MedicamentoEvent();

  @override
  List<Object> get props => [];
}

final class MedicamentoShown extends MedicamentoEvent {}

final class CasaMedicaShown extends MedicamentoEvent {}

final class ComponentePrincipalShown extends MedicamentoEvent {}

final class MedicamentoSaved extends MedicamentoEvent {
  final String name;
  final String description;
  final int idCasaMeidca;
  final int idComponentePrincipal;

  const MedicamentoSaved({
    required this.name,
    required this.description,
    required this.idCasaMeidca,
    required this.idComponentePrincipal,
  });
}

final class MedicamentoUpdated extends MedicamentoEvent {
  final int id;
  final String name;
  final String description;
  final int idCasaMeidca;
  final int idComponentePrincipal;

  const MedicamentoUpdated({
    required this.id,
    required this.name,
    required this.description,
    required this.idCasaMeidca,
    required this.idComponentePrincipal,
  });
}

final class MedicamentoDeleted extends MedicamentoEvent {
  final int medicamentoID;

  const MedicamentoDeleted({
    required this.medicamentoID,
  });
}
