import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/notifications/domain/entities/notification_item.dart';
import 'package:qredet/features/notifications/domain/entities/notifications_page.dart';
import 'package:qredet/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:qredet/features/notifications/domain/usecases/get_notifications.dart';

import 'get_notifications_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotificationsRepository>()])
void main() {
  late MockNotificationsRepository repository;
  late GetNotifications usecase;

  setUpAll(() {
    provideDummy<Either<Failure, NotificationsPage>>(
      const Left(Failure.unknown()),
    );
  });

  setUp(() {
    repository = MockNotificationsRepository();
    usecase = GetNotifications(repository);
  });

  final items = [
    NotificationItem(
      id: '1',
      type: NotificationType.paymentReceived,
      timestamp: DateTime(2025, 5, 21),
      isRead: false,
    ),
  ];
  const params = GetNotificationsParams(page: 1, pageSize: 8);

  test('returns a NotificationsPage from the repository on success', () async {
    when(repository.getNotifications(page: 1, pageSize: 8)).thenAnswer(
      (_) async => Right(NotificationsPage(items: items, hasMore: true)),
    );

    final result = await usecase(params);

    expect(result, Right(NotificationsPage(items: items, hasMore: true)));
    verify(repository.getNotifications(page: 1, pageSize: 8)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('returns the repository Failure unchanged on error', () async {
    when(
      repository.getNotifications(page: 1, pageSize: 8),
    ).thenAnswer((_) async => const Left(Failure.network()));

    final result = await usecase(params);

    expect(result, const Left(Failure.network()));
  });
}
