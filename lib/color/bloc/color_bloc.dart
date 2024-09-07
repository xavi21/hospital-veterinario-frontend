import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/color/model/color_list_model.dart';
import 'package:paraiso_canino/color/service/color_service.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorInitial()) {
    on<ColorShown>(getColors);
    on<ColorSaved>(createColor);
    on<ColorEdited>(updateColor);
    on<ColorDeleted>(deleteColor);
  }

  final ColorService service = ColorService();

  Future<void> getColors(
    ColorShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ColorInProgress(),
    );
    try {
      final List<ColorListModel> resp = await service.getColors();
      emit(
        ColorSuccess(colores: resp),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ColorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createColor(
    ColorSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ColorInProgress(),
    );
    try {
      await service.createColor(
        name: event.name,
      );
      emit(
        ColorCreatedSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ColorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateColor(
    ColorEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ColorInProgress(),
    );
    try {
      await service.updateColor(
        id: event.id,
        name: event.name,
      );
      emit(
        ColorEditedSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ColorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteColor(
    ColorDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ColorInProgress(),
    );
    try {
      await service.deleteColor(
        id: event.colorId,
      );
      emit(
        ColorDeletedSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          ColorError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
