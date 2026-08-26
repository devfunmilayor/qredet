import '../domain/entities/notification_item.dart';

final List<NotificationItem> notificationCatalog = [
  NotificationItem(
    id: 'notif_1',
    title: 'Payment received',
    body: 'You received 637F from Grace Hopper',
    timestamp: DateTime(2025, 5, 21, 16, 1),
    isRead: false,
  ),
  NotificationItem(
    id: 'notif_2',
    title: 'Payment sent',
    body: 'You sent 500F to Ada Lovelace',
    timestamp: DateTime(2025, 5, 20, 9, 12),
    isRead: false,
  ),
  NotificationItem(
    id: 'notif_3',
    title: 'Upgrade available',
    body: 'Upgrade to Premium to remove transaction limits',
    timestamp: DateTime(2025, 5, 18, 14, 30),
    isRead: true,
  ),
  NotificationItem(
    id: 'notif_4',
    title: 'Security alert',
    body: 'A new login to your account was detected',
    timestamp: DateTime(2025, 5, 15, 8, 5),
    isRead: true,
  ),
];
