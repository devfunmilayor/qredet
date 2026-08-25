import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/login_as_guest.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/watch_auth_state.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Shared app-wide singleton (not a per-injection factory) so go_router's
/// redirect and every widget reading auth state see the same instance.
@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._login, this._signUp, this._loginAsGuest, this._logout, this._watchAuthState)
      : super(const AuthState.unknown()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthUserChanged>(_onUserChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<GuestLoginRequested>(_onGuestLoginRequested);
    on<LoggedOut>(_onLoggedOut);
  }

  final Login _login;
  final SignUp _signUp;
  final LoginAsGuest _loginAsGuest;
  final Logout _logout;
  final WatchAuthState _watchAuthState;
  StreamSubscription<AppUser?>? _authSub;

  Future<void> _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    await _authSub?.cancel();
    _authSub = _watchAuthState().listen((user) => add(AuthEvent.userChanged(user)));
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(event.user == null ? const AuthState.unauthenticated() : AuthState.authenticated(event.user!));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthState.authenticating());
    final result = await _login(LoginParams(email: event.email, password: event.password));
    result.match((failure) => emit(AuthState.error(failure)), (_) {});
  }

  Future<void> _onSignUpSubmitted(SignUpSubmitted event, Emitter<AuthState> emit) async {
    emit(const AuthState.authenticating());
    final result = await _signUp(LoginParams(email: event.email, password: event.password));
    result.match((failure) => emit(AuthState.error(failure)), (_) {});
  }

  Future<void> _onGuestLoginRequested(GuestLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.authenticating());
    final result = await _loginAsGuest(const NoParams());
    result.match((failure) => emit(AuthState.error(failure)), (_) {});
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _logout(const NoParams());
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
