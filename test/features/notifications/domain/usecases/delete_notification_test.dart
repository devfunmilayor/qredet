import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:qredet/features/notifications/domain/usecases/delete_notification.dart';

import 'delete_notification_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotificationsRepository>()])
void main() {
  late MockNotificationsRepository repository;
  late DeleteNotification usecase;

  setUpAll(() {
    provideDummy<Either<Failure, Unit>>(const Left(Failure.unknown()));
  });

  setUp(() {
    repository = MockNotificationsRepository();
    usecase = DeleteNotification(repository);
  });

  test('delegates to the repository with the given id', () async {
    when(
      repository.deleteNotification('notif_1'),
    ).thenAnswer((_) async => const Right(unit));

    final result = await usecase('notif_1');

    expect(result, const Right(unit));
    verify(repository.deleteNotification('notif_1')).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('returns the repository Failure unchanged on error', () async {
    when(
      repository.deleteNotification('notif_1'),
    ).thenAnswer((_) async => const Left(Failure.unknown('boom')));

    final result = await usecase('notif_1');

    expect(result, const Left(Failure.unknown('boom')));
  });
}
