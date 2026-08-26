import 'package:equatable/equatable.dart';

enum NotificationType {
  paymentReceived,
  paymentSent,
  upgradeAvailable,
  securityAlert,
  weeklySummary,
}

class NotificationItem extends Equatable {
  const NotificationItem({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.isRead,
  });

  final String id;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;

  @override
  List<Object?> get props => [id, type, timestamp, isRead];
}
