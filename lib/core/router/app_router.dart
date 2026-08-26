import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/payment/presentation/payment_details_screen.dart';
import '../../features/payment/presentation/payment_success_screen.dart';
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
      GoRoute(path: AppRoutes.notifications, builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: AppRoutes.paymentDetails, builder: (context, state) => const PaymentDetailsScreen()),
      GoRoute(path: AppRoutes.paymentSuccess, builder: (context, state) => const PaymentSuccessScreen()),
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
  return isAuthRoute ? null : AppRoutes.login;
}
