import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/notifications_repository.dart';

@lazySingleton
class DeleteNotification implements UseCase<Unit, String> {
  const DeleteNotification(this._repository);

  final NotificationsRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String params) => _repository.deleteNotification(params);
}
