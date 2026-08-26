import 'package:mockito/annotations.dart';
import 'package:qredet/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:qredet/features/notifications/domain/usecases/delete_notification.dart';
import 'package:qredet/features/notifications/domain/usecases/get_notifications.dart';
import 'package:qredet/features/notifications/domain/usecases/mark_notification_read.dart';

@GenerateNiceMocks([
  MockSpec<NotificationsRepository>(),
  MockSpec<GetNotifications>(),
  MockSpec<DeleteNotification>(),
  MockSpec<MarkNotificationRead>(),
])
void main() {}
