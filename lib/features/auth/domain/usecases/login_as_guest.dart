import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class LoginAsGuest implements UseCase<AppUser, NoParams> {
  const LoginAsGuest(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AppUser>> call(NoParams params) =>
      _repository.loginAsGuest();
}
