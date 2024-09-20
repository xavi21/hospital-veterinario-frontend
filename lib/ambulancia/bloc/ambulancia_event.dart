part of 'ambulancia_bloc.dart';

abstract class AmbulanciaEvent extends Equatable {
  const AmbulanciaEvent();

  @override
  List<Object> get props => [];
}

final class AmbulanciaListShown extends AmbulanciaEvent {}

final class AmbulanciaSaved extends AmbulanciaEvent {
  final String placa;
  final String marca;
  final String modelo;
  final String latitud;
  final String longitud;
  final int idEmpleado;

  const AmbulanciaSaved({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.latitud,
    required this.longitud,
    required this.idEmpleado,
  });
}

final class AmbulanciaEdited extends AmbulanciaEvent {
  final String placa;
  final String marca;
  final String modelo;
  final String latitud;
  final String longitud;
  final int idEmpleado;
  final int idAmbulancia;

  const AmbulanciaEdited({
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.latitud,
    required this.longitud,
    required this.idEmpleado,
    required this.idAmbulancia,
  });
}

final class AmbulanciaDeleted extends AmbulanciaEvent {
  final int id;

  const AmbulanciaDeleted({
    required this.id,
  });
}
