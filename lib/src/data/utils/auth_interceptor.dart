import 'package:dio/dio.dart';
import 'package:flutter_redrocket_test_task/src/data/handlers/auth_token_handler.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final AuthTokenHandler _authTokenManager;

  AuthInterceptor(this._authTokenManager);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _authTokenManager.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _authTokenManager.removeToken();
    }

    super.onError(err, handler);
  }
}
