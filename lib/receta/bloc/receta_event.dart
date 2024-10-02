part of 'receta_bloc.dart';

abstract class RecetaEvent extends Equatable {
  const RecetaEvent();

  @override
  List<Object> get props => [];
}

final class MedicinasListShown extends RecetaEvent {}

final class DetalleRecetaShown extends RecetaEvent {
  final int idReceta;

  const DetalleRecetaShown({
    required this.idReceta,
  });
}

final class RecetaSaved extends RecetaEvent {
  final int idconsulta;
  final String observaciones;

  const RecetaSaved({
    required this.idconsulta,
    required this.observaciones,
  });
}

final class DetalleRecetaSaved extends RecetaEvent {
  final int cantidad;
  final int idReceta;
  final int idMedicamento;
  final String indicaciones;

  const DetalleRecetaSaved({
    required this.cantidad,
    required this.idReceta,
    required this.idMedicamento,
    required this.indicaciones,
  });
}

final class RecetaUpdated extends RecetaEvent {
  final int idReceta;
  final int idconsulta;
  final String observaciones;

  const RecetaUpdated({
    required this.idReceta,
    required this.idconsulta,
    required this.observaciones,
  });
}

final class RecetaDeleted extends RecetaEvent {
  final int idReceta;

  const RecetaDeleted({
    required this.idReceta,
  });
}
