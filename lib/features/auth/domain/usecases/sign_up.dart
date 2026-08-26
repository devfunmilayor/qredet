import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/domain/repositories/auth_repository.dart';
import 'package:qredet/features/auth/domain/usecases/login.dart';

@lazySingleton
class SignUp implements UseCase<AppUser, LoginParams> {
  const SignUp(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AppUser>> call(LoginParams params) {
    return _repository.signUp(email: params.email, password: params.password);
  }
}
