part of 'mascota_bloc.dart';

abstract class TipoMascotaState extends BaseState {}

final class TipoMascotaInitial extends TipoMascotaState {}

final class TipoMascotaInProgress extends TipoMascotaState {}

final class TipoMascotaSuccess extends TipoMascotaState {
  final List<TipoMascotaListModel> tipoMascotas;

  TipoMascotaSuccess({
    required this.tipoMascotas,
  });
}

final class TipoMascotaCreatedSuccess extends TipoMascotaState {}

final class TipoMascotaEditedSuccess extends TipoMascotaState {}

final class TipoMascotaDeletedSuccess extends TipoMascotaState {}

final class TipoMascotaError extends TipoMascotaState {
  final String message;

  TipoMascotaError({
    required this.message,
  });
}
