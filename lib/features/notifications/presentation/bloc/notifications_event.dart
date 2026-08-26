import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_event.freezed.dart';

@freezed
sealed class NotificationsEvent with _$NotificationsEvent {
  const factory NotificationsEvent.started() = NotificationsStarted;
  const factory NotificationsEvent.moreRequested() = NotificationsMoreRequested;
  const factory NotificationsEvent.deleted(String id) = NotificationDeleted;
  const factory NotificationsEvent.markedRead(String id) =
      NotificationMarkedRead;
}
