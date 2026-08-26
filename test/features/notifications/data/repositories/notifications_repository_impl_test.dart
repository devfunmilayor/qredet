import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qredet/features/notifications/data/repositories/notifications_repository_impl.dart';

void main() {
  late NotificationsRepositoryImpl repository;

  setUp(() {
    repository = NotificationsRepositoryImpl();
  });

  group('getNotifications', () {
    test(
      'returns the first page with hasMore true when more rows remain',
      () async {
        final result = await repository.getNotifications(page: 1, pageSize: 8);

        final page = result.getRight().toNullable()!;
        expect(page.items, hasLength(8));
        expect(page.hasMore, isTrue);
      },
    );

    test('returns the last page with hasMore false', () async {
      final result = await repository.getNotifications(page: 4, pageSize: 8);

      final page = result.getRight().toNullable()!;
      expect(page.items, hasLength(2));
      expect(page.hasMore, isFalse);
    });

    test('returns an empty page past the end of the mock data', () async {
      final result = await repository.getNotifications(page: 10, pageSize: 8);

      final page = result.getRight().toNullable()!;
      expect(page.items, isEmpty);
      expect(page.hasMore, isFalse);
    });
  });

  test('deleteNotification removes the item from subsequent fetches', () async {
    final before = await repository.getNotifications(page: 1, pageSize: 26);
    final firstId = before.getRight().toNullable()!.items.first.id;

    final deleteResult = await repository.deleteNotification(firstId);
    expect(deleteResult, const Right(unit));

    final after = await repository.getNotifications(page: 1, pageSize: 26);
    expect(
      after.getRight().toNullable()!.items.map((i) => i.id),
      isNot(contains(firstId)),
    );
    expect(after.getRight().toNullable()!.items, hasLength(25));
  });

  test('markAsRead flips isRead without touching other fields', () async {
    final before = await repository.getNotifications(page: 1, pageSize: 26);
    final target = before.getRight().toNullable()!.items.firstWhere(
      (i) => !i.isRead,
    );

    final markResult = await repository.markAsRead(target.id);
    expect(markResult, const Right(unit));

    final after = await repository.getNotifications(page: 1, pageSize: 26);
    final updated = after.getRight().toNullable()!.items.firstWhere(
      (i) => i.id == target.id,
    );
    expect(updated.isRead, isTrue);
    expect(updated.type, target.type);
    expect(updated.timestamp, target.timestamp);
  });

  test('markAsRead on an unknown id is a harmless no-op', () async {
    final result = await repository.markAsRead('does_not_exist');
    expect(result, const Right(unit));
  });
}
