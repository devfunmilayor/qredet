import 'package:injectable/injectable.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class WatchAuthState {
  const WatchAuthState(this._repository);

  final AuthRepository _repository;

  Stream<AppUser?> call() => _repository.authStateChanges();
}
