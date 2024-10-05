part of 'hospitalizacionmedicamento_bloc.dart';

abstract class HospitalizacionmedicamentoState extends BaseState {}

class HospitalizacionmedicamentoInitial
    extends HospitalizacionmedicamentoState {}

final class HospitalizacionInProgress extends HospitalizacionmedicamentoState {}

final class MedicinasListSuccess extends HospitalizacionmedicamentoState {
  final List<MedicinaListModel> medicinas;
  MedicinasListSuccess({
    required this.medicinas,
  });
}

final class HospitalizacionListSuccess extends HospitalizacionmedicamentoState {
  final List<HospitalizacionListModel> hospitalizaciones;
  HospitalizacionListSuccess({
    required this.hospitalizaciones,
  });
}

final class HospitalCreatedSuccess extends HospitalizacionmedicamentoState {}

final class HospitalEditedSuccess extends HospitalizacionmedicamentoState {}

final class HospitalizacionError extends HospitalizacionmedicamentoState {
  final String message;

  HospitalizacionError({
    required this.message,
  });
}
