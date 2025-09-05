import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redrocket_test_task/src/app.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth/auth_state.dart';
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
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message) => _showAuthError(context, message),
                  authenticated: (_) => context.goNamed(Routes.mainScreen.name),
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return LoginWidget(
                  isLoading: isLoading,
                  onSubmit: (email, password) {
                    context.read<AuthCubit>().onlogIn(
                      email: email,
                      password: password,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
