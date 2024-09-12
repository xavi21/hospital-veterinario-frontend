part of 'mascota_bloc.dart';

abstract class TipoMascotaEvent extends Equatable {
  const TipoMascotaEvent();

  @override
  List<Object> get props => [];
}

final class MascotaShown extends TipoMascotaEvent {}

final class MascotaSaved extends TipoMascotaEvent {
  final String name;

  const MascotaSaved({
    required this.name,
  });
}

final class MascotaEdited extends TipoMascotaEvent {
  final int id;
  final String name;

  const MascotaEdited({
    required this.id,
    required this.name,
  });
}

final class MascotaDeleted extends TipoMascotaEvent {
  final int mascotaId;

  const MascotaDeleted({
    required this.mascotaId,
  });
}
