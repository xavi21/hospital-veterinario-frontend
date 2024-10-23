part of 'dashboard_bloc.dart';

abstract class DashboardState extends BaseState {}

class DashboardInitial extends DashboardState {}

class DashboardInProgress extends DashboardState {}

class DashboardConsultaSuccess extends DashboardState {
  final List<ConsultaListModel> consultas;

  DashboardConsultaSuccess({
    required this.consultas,
  });
}

class DashboardGroomingSuccess extends DashboardState {
  final List<GroomingListModel> groomings;

  DashboardGroomingSuccess({
    required this.groomings,
  });
}

class DashboardMascotaSuccess extends DashboardState {
  final List<MascotaListModel> mascotas;

  DashboardMascotaSuccess({
    required this.mascotas,
  });
}

class DashboardHospitalizacionSuccess extends DashboardState {
  final List<HospitalizacionListModel> hospitalizaciones;

  DashboardHospitalizacionSuccess({
    required this.hospitalizaciones,
  });
}

class DashboardServiceError extends DashboardState {
  final String message;

  DashboardServiceError({
    required this.message,
  });
}
