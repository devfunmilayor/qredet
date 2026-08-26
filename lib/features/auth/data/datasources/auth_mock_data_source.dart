import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/data/datasources/auth_data_source.dart';

@lazySingleton
class AuthMockDataSource implements AuthDataSource {
  AuthMockDataSource();

  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _currentUser;
  int _nextUid = 1;

  void _emit(AppUser? user) {
    _currentUser = user;
    _controller.add(user);
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (password.length < 6) throw Exception('Incorrect email or password');
    final user = AppUser(
      uid: 'mock_${_nextUid++}',
      email: email,
      isAnonymous: false,
    );
    _emit(user);
    return user;
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }
    final user = AppUser(
      uid: 'mock_${_nextUid++}',
      email: email,
      isAnonymous: false,
    );
    _emit(user);
    return user;
  }

  @override
  Future<AppUser> loginAsGuest() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final user = AppUser(uid: 'guest_${_nextUid++}', isAnonymous: true);
    _emit(user);
    return user;
  }

  @override
  Future<void> logout() async {
    _emit(null);
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return Stream.multi((controller) {
      controller.add(_currentUser);
      final sub = _controller.stream.listen(controller.add);
      controller.onCancel = sub.cancel;
    });
  }
}
