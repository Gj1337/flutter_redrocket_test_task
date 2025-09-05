import 'package:injectable/injectable.dart';

class MockAccount {
  final String email;
  final String password;
  final String name;

  MockAccount({
    required this.email,
    required this.password,
    required this.name,
  });
}

@module
abstract class MockAccountsModule {
  @singleton
  List<MockAccount> get mockAccounts => [
    MockAccount(email: 'user1@test.com', password: 'password1', name: 'User1'),
    MockAccount(email: 'user2@test.com', password: 'password2', name: 'User2'),
  ];
}
