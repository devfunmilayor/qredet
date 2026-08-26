import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/notifications/domain/usecases/mark_notification_read.dart';

import '../../notifications_mocks.mocks.dart';

void main() {
  late MockNotificationsRepository repository;
  late MarkNotificationRead usecase;

  setUpAll(() {
    provideDummy<Either<Failure, Unit>>(const Left(Failure.unknown()));
  });

  setUp(() {
    repository = MockNotificationsRepository();
    usecase = MarkNotificationRead(repository);
  });

  test('delegates to the repository with the given id', () async {
    when(
      repository.markAsRead('notif_1'),
    ).thenAnswer((_) async => const Right(unit));

    final result = await usecase('notif_1');

    expect(result, const Right(unit));
    verify(repository.markAsRead('notif_1')).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('returns the repository Failure unchanged on error', () async {
    when(
      repository.markAsRead('notif_1'),
    ).thenAnswer((_) async => const Left(Failure.timeout()));

    final result = await usecase('notif_1');

    expect(result, const Left(Failure.timeout()));
  });
}
