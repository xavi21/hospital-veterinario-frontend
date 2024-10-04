part of 'hospitalizacion_bloc.dart';

abstract class HospitalizacionState extends BaseState {}

class HospitalizacionInitial extends HospitalizacionState {}

final class HospitalizacionInProgress extends HospitalizacionState {}

final class HospitalizacionSuccess extends HospitalizacionState {
  final List<HospitalizacionListModel> hospitalizaciones;

  HospitalizacionSuccess({
    required this.hospitalizaciones,
  });
}

final class HospitalizacionEditedSuccess extends HospitalizacionState {}

final class HospitalizacionError extends HospitalizacionState {
  final String message;

  HospitalizacionError({
    required this.message,
  });
}
