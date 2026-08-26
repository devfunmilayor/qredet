import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/error.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<Either<Failure, AppUser>> login({required String email, required String password}) {
    return _guard(() => _dataSource.login(email: email, password: password));
  }

  @override
  Future<Either<Failure, AppUser>> signUp({required String email, required String password}) {
    return _guard(() => _dataSource.signUp(email: email, password: password));
  }

  @override
  Future<Either<Failure, AppUser>> loginAsGuest() => _guard(_dataSource.loginAsGuest);

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _dataSource.logout();
      return const Right(unit);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Stream<AppUser?> authStateChanges() => _dataSource.authStateChanges();

  Future<Either<Failure, AppUser>> _guard(Future<AppUser> Function() action) async {
    try {
      return Right(await action());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
