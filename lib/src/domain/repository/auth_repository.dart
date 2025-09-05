import 'package:flutter_redrocket_test_task/src/domain/entity/auth_status.dart';

abstract class AuthRepository {
  Future<void> logIn({required String email, required String password});

  Future<void> logOut();

  Future<AuthStatus> getAuthStatus();

  Stream<AuthStatus> authStatusStream();
}
