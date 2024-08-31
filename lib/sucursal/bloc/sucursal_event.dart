part of 'sucursal_bloc.dart';

abstract class SucursalEvent extends Equatable {
  const SucursalEvent();

  @override
  List<Object> get props => [];
}

final class OfficeShown extends SucursalEvent {}
