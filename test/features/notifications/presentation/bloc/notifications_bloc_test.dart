import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/notifications/domain/entities/notification_item.dart';
import 'package:qredet/features/notifications/domain/entities/notifications_page.dart';
import 'package:qredet/features/notifications/domain/usecases/get_notifications.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_state.dart';

import '../../notifications_mocks.mocks.dart';

void main() {
  late MockGetNotifications getNotifications;
  late MockDeleteNotification deleteNotification;
  late MockMarkNotificationRead markNotificationRead;

  final item1 = NotificationItem(
    id: '1',
    type: NotificationType.paymentReceived,
    timestamp: DateTime(2025, 5, 21),
    isRead: false,
  );
  final item2 = NotificationItem(
    id: '2',
    type: NotificationType.paymentSent,
    timestamp: DateTime(2025, 5, 20),
    isRead: false,
  );

  setUpAll(() {
    provideDummy<Either<Failure, NotificationsPage>>(
      const Left(Failure.unknown()),
    );
    provideDummy<Either<Failure, Unit>>(const Left(Failure.unknown()));
  });

  setUp(() {
    getNotifications = MockGetNotifications();
    deleteNotification = MockDeleteNotification();
    markNotificationRead = MockMarkNotificationRead();
  });

  NotificationsBloc buildBloc() {
    return NotificationsBloc(
      getNotifications,
      deleteNotification,
      markNotificationRead,
    );
  }

  blocTest<NotificationsBloc, NotificationsState>(
    'emits [loading, loaded] when NotificationsStarted succeeds',
    build: () {
      when(
        getNotifications(const GetNotificationsParams(page: 1, pageSize: 8)),
      ).thenAnswer(
        (_) async =>
            Right(NotificationsPage(items: [item1, item2], hasMore: false)),
      );
      return buildBloc();
    },
    act: (bloc) => bloc.add(const NotificationsEvent.started()),
    expect: () => [
      const NotificationsState(status: NotificationsStatus.loading),
      NotificationsState(
        status: NotificationsStatus.loaded,
        items: [item1, item2],
        hasMore: false,
      ),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'emits [loading, error] when NotificationsStarted fails',
    build: () {
      when(
        getNotifications(const GetNotificationsParams(page: 1, pageSize: 8)),
      ).thenAnswer((_) async => const Left(Failure.network()));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const NotificationsEvent.started()),
    expect: () => [
      const NotificationsState(status: NotificationsStatus.loading),
      const NotificationsState(status: NotificationsStatus.error),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'appends the next page on NotificationsMoreRequested',
    build: () {
      when(
        getNotifications(const GetNotificationsParams(page: 1, pageSize: 8)),
      ).thenAnswer(
        (_) async => Right(NotificationsPage(items: [item1], hasMore: true)),
      );
      when(
        getNotifications(const GetNotificationsParams(page: 2, pageSize: 8)),
      ).thenAnswer(
        (_) async => Right(NotificationsPage(items: [item2], hasMore: false)),
      );
      return buildBloc();
    },
    act: (bloc) async {
      bloc.add(const NotificationsEvent.started());
      await Future<void>.delayed(Duration.zero);
      bloc.add(const NotificationsEvent.moreRequested());
    },
    skip: 2,
    expect: () => [
      NotificationsState(
        status: NotificationsStatus.loaded,
        items: [item1],
        hasMore: true,
        isLoadingMore: true,
      ),
      NotificationsState(
        status: NotificationsStatus.loaded,
        items: [item1, item2],
        hasMore: false,
      ),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'ignores NotificationsMoreRequested when hasMore is false',
    build: buildBloc,
    seed: () =>
        NotificationsState(status: NotificationsStatus.loaded, items: [item1]),
    act: (bloc) => bloc.add(const NotificationsEvent.moreRequested()),
    expect: () => <NotificationsState>[],
    verify: (_) {
      verifyZeroInteractions(getNotifications);
    },
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'removes the item on NotificationDeleted',
    build: () {
      when(deleteNotification('1')).thenAnswer((_) async => const Right(unit));
      return buildBloc();
    },
    seed: () => NotificationsState(
      status: NotificationsStatus.loaded,
      items: [item1, item2],
    ),
    act: (bloc) => bloc.add(const NotificationsEvent.deleted('1')),
    expect: () => [
      NotificationsState(status: NotificationsStatus.loaded, items: [item2]),
    ],
  );

  blocTest<NotificationsBloc, NotificationsState>(
    'marks the item read on NotificationMarkedRead',
    build: () {
      when(
        markNotificationRead('1'),
      ).thenAnswer((_) async => const Right(unit));
      return buildBloc();
    },
    seed: () =>
        NotificationsState(status: NotificationsStatus.loaded, items: [item1]),
    act: (bloc) => bloc.add(const NotificationsEvent.markedRead('1')),
    expect: () => [
      NotificationsState(
        status: NotificationsStatus.loaded,
        items: [
          NotificationItem(
            id: item1.id,
            type: item1.type,
            timestamp: item1.timestamp,
            isRead: true,
          ),
        ],
      ),
    ],
  );
}
