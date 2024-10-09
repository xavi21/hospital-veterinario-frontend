part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

final class ClienteShown extends ClienteEvent {}

final class ClienteDeleted extends ClienteEvent {
  final int clienteID;

  const ClienteDeleted({
    required this.clienteID,
  });
}
