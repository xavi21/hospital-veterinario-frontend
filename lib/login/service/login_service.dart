import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/client_factory.dart';
import 'package:paraiso_canino/login/model/login_response.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

class LoginService {
  Dio client;

  LoginService() : client = ClientFactory.buildClient();

  LoginService.withClient(
    this.client,
  );

  Future<LoginResponse> authUser({
    required String username,
    required String password,
  }) async {
    final response = await client.post(
      authPath,
      data: {
        'idusuario': username,
        'password': password,
      },
    );
    return LoginResponse.fromJson(response.data);
  }
}
