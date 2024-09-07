part of 'mascota_bloc.dart';

abstract class MascotaState extends BaseState {}

final class MascotaInitial extends MascotaState {}

final class MascotaInProgress extends MascotaState {}

final class MascotaSuccess extends MascotaState {
  final List<MascotaListModel> mascotas;

  MascotaSuccess({
    required this.mascotas,
  });
}

final class MascotaCreatedSuccess extends MascotaState {}

final class MascotaEditedSuccess extends MascotaState {}

final class MascotaDeletedSuccess extends MascotaState {}

final class MascotaError extends MascotaState {
  final String message;

  MascotaError({
    required this.message,
  });
}
