import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:qredet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qredet/features/auth/presentation/bloc/auth_state.dart';
import 'package:qredet/features/auth/presentation/login_screen.dart';
import 'package:qredet/features/auth/presentation/sign_up_screen.dart';
import 'package:qredet/features/home/presentation/home_screen.dart';
import 'package:qredet/features/notifications/presentation/notifications_screen.dart';
import 'package:qredet/features/payment/presentation/payment_details_screen.dart';
import 'package:qredet/features/payment/presentation/payment_success_screen.dart';
import 'package:qredet/features/splash/presentation/splash_screen.dart';
import 'package:qredet/features/transactions/presentation/transactions_page.dart';
import 'package:qredet/core/router/app_routes.dart';
import 'package:qredet/core/router/go_router_refresh_stream.dart';
import 'package:qredet/core/router/splash_gate.dart';

GoRouter buildRouter(AuthBloc authBloc, SplashGate splashGate) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: Listenable.merge([
      GoRouterRefreshStream(authBloc.stream),
      splashGate,
    ]),
    redirect: (context, state) =>
        _redirect(authBloc.state, splashGate.isReady, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.transactions,
        builder: (context, state) => const TransactionsPage(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentDetails,
        builder: (context, state) => const PaymentDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentSuccess,
        builder: (context, state) => const PaymentSuccessScreen(),
      ),
    ],
  );
}

String? _redirect(AuthState authState, bool splashReady, String location) {
  final isAuthRoute =
      location == AppRoutes.login || location == AppRoutes.signUp;

  if (authState is AuthUnknown || !splashReady) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }
  if (authState is AuthAuthenticated) {
    return (location == AppRoutes.splash || isAuthRoute)
        ? AppRoutes.home
        : null;
  }
  return isAuthRoute ? null : AppRoutes.login;
}
