part of 'consultalaboratorio_bloc.dart';

abstract class ConsultalaboratorioEvent extends Equatable {
  const ConsultalaboratorioEvent();

  @override
  List<Object> get props => [];
}

final class LaboratorioShown extends ConsultalaboratorioEvent {}
