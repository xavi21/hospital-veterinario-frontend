part of 'consulta_bloc.dart';

abstract class ConsultaEvent extends Equatable {
  const ConsultaEvent();

  @override
  List<Object> get props => [];
}

final class ConsultaShown extends ConsultaEvent {}

final class ConsultaDeleted extends ConsultaEvent {
  final int consultaID;

  const ConsultaDeleted({
    required this.consultaID,
  });
}
