import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/guess_factory.dart';
import 'package:paraiso_canino/login/model/login_response.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class LoginService {
  Dio guess;

  LoginService() : guess = GuessFactory.buildClient();

  LoginService.withClient(
    this.guess,
  );

  Future<LoginResponse> authUser({
    required String username,
    required String password,
  }) async {
    final response = await guess.post(
      authPath,
      data: {
        'idusuario': username,
        'password': password,
      },
    );
    return LoginResponse.fromJson(response.data);
  }
}
