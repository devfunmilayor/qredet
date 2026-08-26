import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/app_user.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkRequested() = AuthCheckRequested;
  const factory AuthEvent.userChanged(AppUser? user) = AuthUserChanged;
  const factory AuthEvent.loginSubmitted({
    required String email,
    required String password,
  }) = LoginSubmitted;
  const factory AuthEvent.signUpSubmitted({
    required String email,
    required String password,
  }) = SignUpSubmitted;
  const factory AuthEvent.guestLoginRequested() = GuestLoginRequested;
  const factory AuthEvent.loggedOut() = LoggedOut;
}
