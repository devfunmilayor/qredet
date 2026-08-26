import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qredet/features/notifications/domain/entities/notification_item.dart';

part 'notifications_state.freezed.dart';

enum NotificationsStatus { loading, loaded, error }

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(NotificationsStatus.loading) NotificationsStatus status,
    @Default(<NotificationItem>[]) List<NotificationItem> items,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _NotificationsState;
}
