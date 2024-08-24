import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/login/model/login_response.dart';
import 'package:paraiso_canino/login/service/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailPassword>(userLogin);
  }

  Future<void> userLogin(
    LoginWithEmailPassword event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LoginInProgress(),
    );

    final LoginService service = LoginService();

    try {
      LoginResponse resp = await service.authUser(
        username: event.codeEmail,
        password: event.password,
      );
      emit(
        LoginSuccess(loginResponse: resp),
      );
    } on DioException catch (error) {
      emit(
        LoginError(error: error.response!.data!['message']),
      );
      // if (error.response?.statusCode == null ||
      //     error.response!.statusCode! >= 500 ||
      //     error.response!.data[responseCode]) {
      //   emit(
      //     ServerClientError(),
      //   );
      // } else {
      //   emit(
      //     LoginError(error: error.response!.data!['status']),
      //   );
      // }
    }
  }
}
