part of 'detalleconsulta_bloc.dart';

abstract class DetalleconsultaEvent extends Equatable {
  const DetalleconsultaEvent();

  @override
  List<Object> get props => [];
}

final class CitasListShown extends DetalleconsultaEvent {}

final class EmpleadosListShown extends DetalleconsultaEvent {}
