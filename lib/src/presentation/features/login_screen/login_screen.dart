import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redrocket_test_task/src/app.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth_cubit.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth_state.dart';
import 'package:flutter_redrocket_test_task/src/presentation/features/login_screen/widget/login_widget.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _showAuthError(BuildContext context, String error) {
    final displayError = 'Authorization error:\r\n$error';

    final snackBar = SnackBar(content: Text(displayError));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(10),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                _showAuthError(context, state.message);
              }
              if (state is Authenticated) {
                context.goNamed(Routes.mainScreen.name);
              }
            },
            builder: (context, state) {
              final isLoading = state is Loading;

              return LoginWidget(
                isLoading: isLoading,
                onSubmit: (email, password) {
                  context.read<AuthCubit>().logIn(
                    email: email,
                    password: password,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
