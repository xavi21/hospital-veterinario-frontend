part of 'sucursal_bloc.dart';

abstract class SucursalEvent extends Equatable {
  const SucursalEvent();

  @override
  List<Object> get props => [];
}

final class OfficeShown extends SucursalEvent {}

final class OfficeSaved extends SucursalEvent {
  final String name;
  final String direction;

  const OfficeSaved({
    required this.name,
    required this.direction,
  });
}

final class OfficeEdited extends SucursalEvent {
  final int id;
  final String name;
  final String direction;

  const OfficeEdited({
    required this.id,
    required this.name,
    required this.direction,
  });
}

final class OfficeDeleted extends SucursalEvent {
  final int officeID;

  const OfficeDeleted({
    required this.officeID,
  });
}
