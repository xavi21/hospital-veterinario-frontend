import 'package:dio/dio.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

final class ClientFactory {
  static Dio buildClient() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (int? status) => status! <= 200,
      ),
    );

    dio.interceptors.add(
      LogInterceptor(),
    );
    return dio;
  }
}
