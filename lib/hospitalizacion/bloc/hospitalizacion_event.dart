part of 'hospitalizacion_bloc.dart';

abstract class HospitalizacionEvent extends Equatable {
  const HospitalizacionEvent();

  @override
  List<Object> get props => [];
}

final class HospitalizacionShown extends HospitalizacionEvent {}
