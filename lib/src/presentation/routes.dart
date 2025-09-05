part of "../app.dart";

typedef RouteInfo = ({String name, String path});

abstract final class Routes {
  static const RouteInfo mainScreen = (path: '/main', name: 'main');
  static const RouteInfo loginScreen = (path: '/login', name: 'login');
}

GoRouter _buildRouter(BuildContext context) {
  final loginScreenRoute = GoRoute(
    path: Routes.loginScreen.path,
    name: Routes.loginScreen.name,
    builder: (context, state) => const LoginScreen(),
  );

  final mainScreenRoute = GoRoute(
    path: Routes.mainScreen.path,
    name: Routes.mainScreen.name,
    builder: (context, state) => const MainScreen(),
  );

  final authNotifier = StreamListenable(context.read<AuthCubit>().stream);

  return GoRouter(
    initialLocation: Routes.mainScreen.path,
    routes: [loginScreenRoute, mainScreenRoute],

    refreshListenable: authNotifier,
    redirect: (context, state) {
      final alreadyOnLoginScreen = state.fullPath!.startsWith(
        Routes.loginScreen.path,
      );

      if (alreadyOnLoginScreen) {
        return null;
      }

      final authState = context.read<AuthCubit>().state;

      return authState.maybeWhen(
        unauthenticated: () => Routes.loginScreen.path,
        orElse: () => null,
      );
    },
  );
}
