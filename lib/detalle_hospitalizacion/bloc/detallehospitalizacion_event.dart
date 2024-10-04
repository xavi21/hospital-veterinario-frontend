part of 'detallehospitalizacion_bloc.dart';

abstract class DetallehospitalizacionEvent extends Equatable {
  const DetallehospitalizacionEvent();

  @override
  List<Object> get props => [];
}

final class MascotasListShown extends DetallehospitalizacionEvent {}

final class JaulasListShown extends DetallehospitalizacionEvent {}

final class HospitalizacionSaved extends DetallehospitalizacionEvent {
  final int idmascota;
  final int idjaula;
  final String fechaingreso;
  final String fechasalida;
  final String motivo;
  final String observaciones;

  const HospitalizacionSaved({
    required this.idmascota,
    required this.idjaula,
    required this.fechaingreso,
    required this.fechasalida,
    required this.motivo,
    required this.observaciones,
  });
}

final class HospitalizacionEdited extends DetallehospitalizacionEvent {
  final int idhospitalizacion;
  final int idmascota;
  final int idjaula;
  final String fechaingreso;
  final String fechasalida;
  final String motivo;
  final String observaciones;

  const HospitalizacionEdited({
    required this.idhospitalizacion,
    required this.idmascota,
    required this.idjaula,
    required this.fechaingreso,
    required this.fechasalida,
    required this.motivo,
    required this.observaciones,
  });
}
