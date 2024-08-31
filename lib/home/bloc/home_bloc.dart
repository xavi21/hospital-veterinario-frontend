import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/home/model/menu_list.dart';
import 'package:paraiso_canino/home/model/submenu_list.dart';
import 'package:paraiso_canino/home/service/home_service.dart';
import 'package:paraiso_canino/repository/user_repository.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeMenuShown>(getNavigationMenu);
  }

  final HomeService service = HomeService();

  Future<void> getNavigationMenu(
    HomeMenuShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      HomeinProgress(),
    );
    try {
      final List<MenuListModel> menuResp = await service.getMenu();
      final List<SubMenuListModel> subMenuResp = await service.getSubMenu();

      menuResp.sort(
        (a, b) => a.ordenmenu.compareTo(b.ordenmenu),
      );

      subMenuResp.sort(
        (a, b) => a.idopcion.compareTo(b.idopcion),
      );

      final String savedMail = await UserRepository().getReminderEmail();

      emit(
        HomeGetMenuSuccess(
          menu: menuResp,
          subMenu: subMenuResp,
          userEmail: savedMail,
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
          HomeServiceError(
            message: error.response!.data![responseMessage],
          ),
        );
      }
    }
  }
}
