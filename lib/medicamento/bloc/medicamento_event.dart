part of 'medicamento_bloc.dart';

abstract class MedicamentoEvent extends Equatable {
  const MedicamentoEvent();

  @override
  List<Object> get props => [];
}

final class MedicamentoShown extends MedicamentoEvent {}

final class MedicamentoDeleted extends MedicamentoEvent {
  final int medicamentoID;

  const MedicamentoDeleted({
    required this.medicamentoID,
  });
}
