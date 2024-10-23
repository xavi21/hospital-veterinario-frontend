part of 'mascota_bloc.dart';

abstract class TipoMascotaEvent extends Equatable {
  const TipoMascotaEvent();

  @override
  List<Object> get props => [];
}

final class TipoMascotaShown extends TipoMascotaEvent {}

final class GeneroShown extends TipoMascotaEvent {}

final class PersonaShown extends TipoMascotaEvent {}

final class ColorShown extends TipoMascotaEvent {}

final class TallaShown extends TipoMascotaEvent {}

final class MascotaShown extends TipoMascotaEvent {}

final class MascotaSaved extends TipoMascotaEvent {
  final int idTipoMascota;
  final int idGenero;
  final int idPersona;
  final int idColor;
  final int idTalla;
  final String name;
  final String peso;

  const MascotaSaved({
    required this.idTipoMascota,
    required this.idGenero,
    required this.idPersona,
    required this.idColor,
    required this.idTalla,
    required this.name,
    required this.peso,
  });
}

final class MascotaEdited extends TipoMascotaEvent {
  final int id;
  final int idTipoMascota;
  final int idGenero;
  final int idPersona;
  final int idColor;
  final int idTalla;
  final String name;
  final String peso;

  const MascotaEdited({
    required this.id,
    required this.idTipoMascota,
    required this.idGenero,
    required this.idPersona,
    required this.idColor,
    required this.idTalla,
    required this.name,
    required this.peso,
  });
}

final class MascotaDeleted extends TipoMascotaEvent {
  final int mascotaId;

  const MascotaDeleted({
    required this.mascotaId,
  });
}
