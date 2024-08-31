part of 'sucursal_bloc.dart';

abstract class SucursalState extends BaseState {}

final class SucursalInitial extends SucursalState {}

final class SucursalInProgress extends SucursalState {}

final class SucursalSuccess extends SucursalState {
  final List<OfficeListModel> sucursales;

  SucursalSuccess({
    required this.sucursales,
  });
}

final class SucursalError extends SucursalState {
  final String message;

  SucursalError({
    required this.message,
  });
}