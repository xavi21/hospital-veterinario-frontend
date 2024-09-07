part of 'mascota_bloc.dart';

abstract class MascotaEvent extends Equatable {
  const MascotaEvent();

  @override
  List<Object> get props => [];
}

final class MascotaShown extends MascotaEvent {}

final class MascotaSaved extends MascotaEvent {
  final String name;

  const MascotaSaved({
    required this.name,
  });
}

final class MascotaEdited extends MascotaEvent {
  final int id;
  final String name;

  const MascotaEdited({
    required this.id,
    required this.name,
  });
}

final class MascotaDeleted extends MascotaEvent {
  final int mascotaId;

  const MascotaDeleted({
    required this.mascotaId,
  });
}
