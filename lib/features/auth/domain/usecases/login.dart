import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/auth/domain/entities/app_user.dart';
import 'package:qredet/features/auth/domain/repositories/auth_repository.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

@lazySingleton
class Login implements UseCase<AppUser, LoginParams> {
  const Login(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AppUser>> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}
