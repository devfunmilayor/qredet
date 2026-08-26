import 'package:fpdart/fpdart.dart';
import '../error/failure.dart';

abstract class UseCase<R, Params> {
  Future<Either<Failure, R>> call(Params params);
}

class NoParams {
  const NoParams();
}
