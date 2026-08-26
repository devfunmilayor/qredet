import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.isRead,
  });

  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  @override
  List<Object?> get props => [id, title, body, timestamp, isRead];
}
