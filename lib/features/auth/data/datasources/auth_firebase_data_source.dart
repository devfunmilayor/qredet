import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/data/datasources/auth_data_source.dart';

@lazySingleton
class AuthFirebaseDataSource implements AuthDataSource {
  const AuthFirebaseDataSource();

  fb.FirebaseAuth get _auth => fb.FirebaseAuth.instance;

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _toAppUser(credential.user!);
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _toAppUser(credential.user!);
  }

  @override
  Future<AppUser> loginAsGuest() async {
    final credential = await _auth.signInAnonymously();
    return _toAppUser(credential.user!);
  }

  @override
  Future<void> logout() => _auth.signOut();

  @override
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map(
      (user) => user == null ? null : _toAppUser(user),
    );
  }

  AppUser _toAppUser(fb.User user) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      isAnonymous: user.isAnonymous,
    );
  }
}
