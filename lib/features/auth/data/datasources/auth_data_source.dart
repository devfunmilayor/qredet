import '../../domain/entities/app_user.dart';

/// Implemented by both [AuthMockDataSource] and [AuthFirebaseDataSource] so
/// [AuthRepositoryImpl] never knows which one is answering.
abstract class AuthDataSource {
  Future<AppUser> login({required String email, required String password});

  Future<AppUser> signUp({required String email, required String password});

  Future<AppUser> loginAsGuest();

  Future<void> logout();

  Stream<AppUser?> authStateChanges();
}
