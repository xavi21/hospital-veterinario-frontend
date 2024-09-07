part of 'talla_bloc.dart';

abstract class TallaEvent extends Equatable {
  const TallaEvent();

  @override
  List<Object> get props => [];
}

final class TallaShown extends TallaEvent {}

final class TallaSaved extends TallaEvent {
  final String name;

  const TallaSaved({
    required this.name,
  });
}

final class TallaEdited extends TallaEvent {
  final int id;
  final String name;

  const TallaEdited({
    required this.id,
    required this.name,
  });
}

final class TallaDeleted extends TallaEvent {
  final int tallaID;

  const TallaDeleted({
    required this.tallaID,
  });
}
