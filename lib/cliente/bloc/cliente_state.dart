part of 'cliente_bloc.dart';

abstract class ClienteState extends BaseState {}

final class ClienteInitial extends ClienteState {}

final class ClienteInProgress extends ClienteState {}

final class ClienteSuccess extends ClienteState {
  final List<ClienteListModel> clientes;

  ClienteSuccess({
    required this.clientes,
  });
}

final class ClienteCreatedSuccess extends ClienteState {}

final class ClienteEditedSuccess extends ClienteState {}

final class ClienteDeletedSuccess extends ClienteState {}

final class ClienteError extends ClienteState {
  final String message;

  ClienteError({
    required this.message,
  });
}
