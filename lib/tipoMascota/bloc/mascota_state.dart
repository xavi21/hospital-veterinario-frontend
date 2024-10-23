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

final class GeneroSuccess extends TipoMascotaState {
  final List<GeneroListModel> genero;

  GeneroSuccess({
    required this.genero,
  });
}

final class PersonaSuccess extends TipoMascotaState {
  final List<PersonaListModel> personas;

  PersonaSuccess({
    required this.personas,
  });
}

final class ColorSuccess extends TipoMascotaState {
  final List<ColorListModel> colores;

  ColorSuccess({
    required this.colores,
  });
}

final class TallaSuccess extends TipoMascotaState {
  final List<TallaListModel> tallas;

  TallaSuccess({
    required this.tallas,
  });
}

final class MascotaSuccess extends TipoMascotaState {
  final List<MascotaListModel> mascotas;

  MascotaSuccess({
    required this.mascotas,
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
