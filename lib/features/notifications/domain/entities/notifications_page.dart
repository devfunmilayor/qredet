import 'package:equatable/equatable.dart';
import 'notification_item.dart';

class NotificationsPage extends Equatable {
  const NotificationsPage({required this.items, required this.hasMore});

  final List<NotificationItem> items;
  final bool hasMore;

  @override
  List<Object?> get props => [items, hasMore];
}
