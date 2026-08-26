import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/notifications/domain/entities/notifications_page.dart';
import 'package:qredet/features/notifications/domain/repositories/notifications_repository.dart';

class GetNotificationsParams extends Equatable {
  const GetNotificationsParams({required this.page, required this.pageSize});

  final int page;
  final int pageSize;

  @override
  List<Object?> get props => [page, pageSize];
}

@lazySingleton
class GetNotifications
    implements UseCase<NotificationsPage, GetNotificationsParams> {
  const GetNotifications(this._repository);

  final NotificationsRepository _repository;

  @override
  Future<Either<Failure, NotificationsPage>> call(
    GetNotificationsParams params,
  ) {
    return _repository.getNotifications(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
