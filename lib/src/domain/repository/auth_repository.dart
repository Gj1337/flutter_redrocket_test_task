import 'package:flutter_redrocket_test_task/src/domain/entity/auth_status.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User> logIn({required String email, required String password});

  Future<void> logOut();

  Future<User?> getUser();

  Future<AuthStatus> getAuthStatus();

  Stream<AuthStatus> authStatusStream();
}
