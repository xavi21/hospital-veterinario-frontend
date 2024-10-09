part of 'genero_bloc.dart';

abstract class GeneroEvent extends Equatable {
  const GeneroEvent();

  @override
  List<Object> get props => [];
}

final class GeneroShown extends GeneroEvent {}

final class GeneroDeleted extends GeneroEvent {
  final int generoID;

  const GeneroDeleted({
    required this.generoID,
  });
}
