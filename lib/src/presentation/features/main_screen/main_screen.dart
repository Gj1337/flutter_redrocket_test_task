import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redrocket_test_task/src/domain/entity/user.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth/auth_state.dart';
import 'package:flutter_redrocket_test_task/src/presentation/features/main_screen/widget/user_info_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              User? user;

              state.whenOrNull(authenticated: (newUser) => user = newUser);

              return Center(
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user != null
                        ? UserInfoWidget(user: user!)
                        : const Text('Something went wrong'),
                    OutlinedButton(
                      onPressed: () => context.read<AuthCubit>().onlogOut(),
                      child: const Text('Log out'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
