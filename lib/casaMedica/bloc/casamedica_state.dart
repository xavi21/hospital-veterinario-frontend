part of 'casamedica_bloc.dart';

abstract class CasamedicaState extends BaseState {}

class CasamedicaInitial extends CasamedicaState {}

final class CasaMedicaInProgress extends CasamedicaState {}

final class CasaMedicaSuccess extends CasamedicaState {
  final List<CasaMedicaListModel> casasMedicas;

  CasaMedicaSuccess({
    required this.casasMedicas,
  });
}

final class CasaMedicaCreatedSuccess extends CasamedicaState {}

final class CasaMedicaEditedSuccess extends CasamedicaState {}

final class CasaMedicaDeletedSuccess extends CasamedicaState {}

final class CasaMedicaError extends CasamedicaState {
  final String message;

  CasaMedicaError({
    required this.message,
  });
}
