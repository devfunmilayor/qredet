import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthUnknown;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticating() = AuthAuthenticating;
  const factory AuthState.authenticated(AppUser user) = AuthAuthenticated;
  const factory AuthState.error(Failure failure) = AuthError;
}
