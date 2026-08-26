import 'package:qredet/features/auth/domain/entities/app_user.dart';

abstract class AuthDataSource {
  Future<AppUser> login({required String email, required String password});

  Future<AppUser> signUp({required String email, required String password});

  Future<AppUser> loginAsGuest();

  Future<void> logout();

  Stream<AppUser?> authStateChanges();
}
