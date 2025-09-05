import 'package:flutter/material.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/user.dart';

class UserInfoWidget extends StatelessWidget {
  final User user;

  const UserInfoWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome, ${user.name}.',
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
