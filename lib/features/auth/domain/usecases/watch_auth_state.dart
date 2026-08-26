import 'package:injectable/injectable.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class WatchAuthState {
  const WatchAuthState(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> call() => _repository.authStateChanges();
}
