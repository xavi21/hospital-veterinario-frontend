part of 'receta_bloc.dart';

abstract class RecetaState extends BaseState {}

final class RecetaInitial extends RecetaState {}

final class RecetaInProgress extends RecetaState {}

final class RecetaMedicinasListSuccess extends RecetaState {
  final List<MedicinaListModel> medicinas;
  RecetaMedicinasListSuccess({
    required this.medicinas,
  });
}

final class DetalleRecetasListSuccess extends RecetaState {
  final List<RecetaListModel> recetas;
  DetalleRecetasListSuccess({
    required this.recetas,
  });
}

final class RecetaCreatedSuccess extends RecetaState {
  final int idReceta;

  RecetaCreatedSuccess({
    required this.idReceta,
  });
}

final class DetalleRecetaCreatedSuccess extends RecetaState {}

final class RecetaEditedSuccess extends RecetaState {}

final class RecetaDeletedSuccess extends RecetaState {}

final class RecetaServiceError extends RecetaState {
  final String message;

  RecetaServiceError({
    required this.message,
  });
}
