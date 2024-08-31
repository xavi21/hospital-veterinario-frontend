import 'package:dio/dio.dart';
import 'package:paraiso_canino/repository/user_repository.dart';

class HeadersInterceptor extends Interceptor {
  final bool isGuess;

  HeadersInterceptor({
    this.isGuess = false,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!isGuess) {
      final String token = await UserRepository().getBearerToken();
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(
      options,
      handler,
    );
  }
}
