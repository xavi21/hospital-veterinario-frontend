part of 'medicamento_bloc.dart';

abstract class MedicamentoState extends BaseState {}

final class MedicamentoInitial extends MedicamentoState {}

final class MedicamentoInProgress extends MedicamentoState {}

final class MedicamentoSuccess extends MedicamentoState {
  final List<MedicamentoListModel> medicamentos;

  MedicamentoSuccess({
    required this.medicamentos,
  });
}

final class MedicamentoDeletedSuccess extends MedicamentoState {}

final class MedicamentoError extends MedicamentoState {
  final String message;

  MedicamentoError({
    required this.message,
  });
}
