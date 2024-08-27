import 'package:dio/dio.dart';
import 'package:paraiso_canino/factory/headers_interceptor.dart';
import 'package:paraiso_canino/resources/api_constants.dart';

final class ClientFactory {
  static Dio buildClient() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (int? status) => status! <= 201,
      ),
    );

    dio.interceptors
      ..add(
        LogInterceptor(),
      )
      ..add(
        HeadersInterceptor(),
      );
    return dio;
  }
}
