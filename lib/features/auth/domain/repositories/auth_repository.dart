import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> login({required String email, required String password});

  Future<Either<Failure, AppUser>> signUp({required String email, required String password});

  Future<Either<Failure, AppUser>> loginAsGuest();

  Future<Either<Failure, Unit>> logout();

  Stream<AppUser?> authStateChanges();
}
