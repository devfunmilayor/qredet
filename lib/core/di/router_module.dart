import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qredet/core/router/app_router.dart';
import 'package:qredet/core/router/splash_gate.dart';

@module
abstract class RouterModule {
  @lazySingleton
  GoRouter router(AuthBloc authBloc, SplashGate splashGate) =>
      buildRouter(authBloc, splashGate);
}
