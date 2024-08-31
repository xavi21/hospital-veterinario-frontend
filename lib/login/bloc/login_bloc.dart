import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/common/bloc/base_state.dart';
import 'package:paraiso_canino/login/model/login_response.dart';
import 'package:paraiso_canino/login/service/login_service.dart';
import 'package:paraiso_canino/repository/user_repository.dart';
import 'package:paraiso_canino/resources/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginOnLoad>(getReminderMail);
    on<LoginWithEmailPassword>(userLogin);
  }

  final UserRepository _userRepository = UserRepository();

  Future<void> getReminderMail(
    LoginOnLoad event,
    Emitter<BaseState> emit,
  ) async {
    final bool isRememberMail = await _userRepository.rememberMailChecked();
    if (isRememberMail) {
      final String savedMail = await _userRepository.getReminderEmail();
      emit(
        LoginReminderMailSuccess(
          reminderMail: savedMail,
        ),
      );
    }
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
      final LoginResponse resp = await service.authUser(
        username: event.codeEmail,
        password: event.password,
      );

      if (event.rememberEmail) {
        _userRepository.saveRemeberMailCheck(isCkecked: true);
      }

      _userRepository.rememberEmail(
        email: event.codeEmail,
      );

      _userRepository.saveBearerToken(
        newToken: resp.accessToken,
      );

      emit(
        LoginSuccess(),
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
          LoginError(error: error.response!.data![responseMessage]),
        );
      }
    }
  }
}
