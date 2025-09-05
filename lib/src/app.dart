import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth_cubit.dart';
import 'package:flutter_redrocket_test_task/src/presentation/cubit/auth_state.dart';
import 'package:flutter_redrocket_test_task/src/presentation/features/login_screen/login_screen.dart';
import 'package:flutter_redrocket_test_task/src/presentation/features/main_screen/main_screen.dart';
import 'package:flutter_redrocket_test_task/src/presentation/utils/di_provider.dart';
import 'package:flutter_redrocket_test_task/src/presentation/utils/stream_listenable.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

part 'presentation/routes.dart';

class App extends StatelessWidget {
  const App({required this.getIt, super.key});

  final GetIt getIt;

  @override
  Widget build(BuildContext context) {
    return DiProvider(
      getIt: getIt,
      child: BlocProvider(
        lazy: false,
        create: (_) => getIt.get<AuthCubit>()..onCreate(),
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: _buildRouter(context),
            );
          },
        ),
      ),
    );
  }
}
