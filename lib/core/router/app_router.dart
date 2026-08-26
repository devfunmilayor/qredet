import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/transactions/presentation/transactions_page.dart';
import 'app_routes.dart';
import 'go_router_refresh_stream.dart';

GoRouter buildRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) => _redirect(authBloc.state, state.matchedLocation),
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.signUp, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: AppRoutes.transactions, builder: (context, state) => const TransactionsPage()),
    ],
  );
}

String? _redirect(AuthState authState, String location) {
  final isAuthRoute = location == AppRoutes.login || location == AppRoutes.signUp;

  if (authState is AuthUnknown) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }
  if (authState is AuthAuthenticated) {
    return (location == AppRoutes.splash || isAuthRoute) ? AppRoutes.home : null;
  }
  // Unauthenticated, authenticating, or error — stay on/land on an auth route.
  return isAuthRoute ? null : AppRoutes.login;
}
