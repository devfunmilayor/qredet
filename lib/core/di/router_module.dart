import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../router/app_router.dart';
import '../router/splash_gate.dart';

@module
abstract class RouterModule {
  @lazySingleton
  GoRouter router(AuthBloc authBloc, SplashGate splashGate) =>
      buildRouter(authBloc, splashGate);
}
