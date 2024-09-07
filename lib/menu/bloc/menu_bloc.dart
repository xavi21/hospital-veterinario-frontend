import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/menu/model/menu_model.dart';
import 'package:paraiso_canino/menu/service/menu_service.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuListShown>(getMenuList);
    on<MenuSaved>(createMenu);
    on<MenuEdited>(updateMenu);
    on<MenuDeleted>(deleteMenu);
  }

  final MenuService service = MenuService();

  Future<void> getMenuList(
    MenuListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MenuInProgress(),
    );
    try {
      final List<MenuModel> resp = await service.getMenu();
      emit(
        MenuListSuccess(
          menuList: resp,
        ),
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
          MenuServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> createMenu(
    MenuSaved event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MenuInProgress(),
    );
    try {
      await service.createMenu(
        name: event.name,
        orderMenu: event.orderMenu,
      );
      emit(
        MenuCreatedSuccess(),
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
          MenuServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> updateMenu(
    MenuEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MenuInProgress(),
    );
    try {
      await service.updateMenu(
        id: event.id,
        name: event.name,
        orderMenu: event.orderMenu,
      );
      emit(
        MenuEditedSuccess(),
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
          MenuServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> deleteMenu(
    MenuDeleted event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      MenuInProgress(),
    );
    try {
      await service.deleteMenu(id: event.menuID);
      emit(
        MenuCreatedSuccess(),
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
          MenuServiceError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
