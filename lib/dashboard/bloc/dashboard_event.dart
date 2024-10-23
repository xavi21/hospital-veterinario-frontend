part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

final class ConsultaShown extends DashboardEvent {}

final class GroomingShown extends DashboardEvent {}

final class MascotaShown extends DashboardEvent {}

final class HospitalizacionShown extends DashboardEvent {}
