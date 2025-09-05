import 'package:dio/dio.dart';
import 'package:flutter_redrocket_test_task/src/data/datasource/auth_datasource.dart';
import 'package:flutter_redrocket_test_task/src/data/handlers/auth_token_handler.dart';
import 'package:flutter_redrocket_test_task/src/data/entity/login_request.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/auth_status.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/exception/auth_exception.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/user.dart';
import 'package:flutter_redrocket_test_task/src/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImplementation implements AuthRepository {
  final AuthDatasource _authDatasource;
  final AuthHandler _authHandler;

  AuthRepositoryImplementation(this._authDatasource, this._authHandler);

  @override
  Future<User> logIn({required String email, required String password}) async {
    late User user;

    try {
      final loginResponse = await _authDatasource.login(
        LoginRequest(email: email, password: password),
      );

      _authHandler.updateToken(loginResponse.token);
      _authHandler.updateUser(loginResponse.user);

      user = loginResponse.user;
    } on DioException catch (exception) {
      final response = exception.response;

      if (response != null) {
        switch (response.statusCode) {
          case 400:
            throw BadCredentialFormatException();
          case 401:
            throw WrongCredentialException();
          case 404:
            throw AccountNotFoundException();
          default:
            rethrow;
        }
      }
    }

    return user;
  }

  @override
  Future<void> logOut() async {
    _authHandler.removeToken();
    await _authDatasource.logout();
  }

  @override
  Stream<AuthStatus> authStatusStream() {
    return _authHandler.tokenStream.map(_tokenToAuthStatus);
  }

  @override
  Future<AuthStatus> getAuthStatus() async {
    final token = await _authHandler.getToken();

    return _tokenToAuthStatus(token);
  }

  AuthStatus _tokenToAuthStatus(String? token) {
    return switch (token) {
      null => AuthStatus.unauthroized,
      _ => AuthStatus.authroized,
    };
  }

  @override
  Future<User?> getUser() {
    return _authHandler.getUser();
  }
}
