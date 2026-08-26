import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/notifications_page.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, NotificationsPage>> getNotifications({
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, Unit>> deleteNotification(String id);

  Future<Either<Failure, Unit>> markAsRead(String id);
}
