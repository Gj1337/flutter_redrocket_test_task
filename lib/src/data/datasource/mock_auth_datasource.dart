import 'package:dio/dio.dart';
import 'package:flutter_redrocket_test_task/src/data/datasource/auth_datasource.dart';
import 'package:flutter_redrocket_test_task/src/data/datasource/mock_user_module.dart';
import 'package:flutter_redrocket_test_task/src/data/entity/login_request.dart';
import 'package:flutter_redrocket_test_task/src/data/entity/login_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(env: ['test'], as: AuthDatasource)
class MockAuthDatasource implements AuthDatasource {
  final List<MockAccount> _mockAccounts;

  MockAuthDatasource(this._mockAccounts);

  String _generateToken(MockAccount account) {
    final emailPrefix = account.email.split('@')[0];
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'mock_token_${emailPrefix}_$timestamp';
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final email = loginRequest.email.trim();
    final password = loginRequest.password;

    if (email.isEmpty || password.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 400,
          data: {'message': 'Email and password are required'},
          requestOptions: RequestOptions(path: '/login'),
        ),
      );
    }

    MockAccount? foundAccount;
    try {
      foundAccount = _mockAccounts.firstWhere(
        (account) => account.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 404,
          data: {'message': 'Account not found'},
          requestOptions: RequestOptions(path: '/login'),
        ),
      );
    }

    if (foundAccount.password != password) {
      throw DioException(
        requestOptions: RequestOptions(path: '/login'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 401,
          data: {'message': 'Invalid password'},
          requestOptions: RequestOptions(path: '/login'),
        ),
      );
    }

    return LoginResponse(token: _generateToken(foundAccount));
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
