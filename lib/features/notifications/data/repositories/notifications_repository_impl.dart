import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/entities/notifications_page.dart';
import '../../domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl() : _items = List.generate(26, _mockNotificationAt);

  final List<NotificationItem> _items;

  static NotificationItem _mockNotificationAt(int index) {
    return NotificationItem(
      id: 'notif_$index',
      type: NotificationType.values[index % NotificationType.values.length],
      timestamp: DateTime(2025, 5, 21, 16, 1).subtract(Duration(hours: index * 7)),
      isRead: index % 3 == 0,
    );
  }

  @override
  Future<Either<Failure, NotificationsPage>> getNotifications({required int page, required int pageSize}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final start = (page - 1) * pageSize;
    if (start >= _items.length) return const Right(NotificationsPage(items: [], hasMore: false));
    final end = (start + pageSize).clamp(0, _items.length);
    return Right(NotificationsPage(items: _items.sublist(start, end), hasMore: end < _items.length));
  }

  @override
  Future<Either<Failure, Unit>> deleteNotification(String id) async {
    _items.removeWhere((item) => item.id == id);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> markAsRead(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = NotificationItem(
        id: _items[index].id,
        type: _items[index].type,
        timestamp: _items[index].timestamp,
        isRead: true,
      );
    }
    return const Right(unit);
  }
}
