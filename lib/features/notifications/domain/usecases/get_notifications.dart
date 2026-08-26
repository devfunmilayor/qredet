import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/notifications_page.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsParams extends Equatable {
  const GetNotificationsParams({required this.page, required this.pageSize});

  final int page;
  final int pageSize;

  @override
  List<Object?> get props => [page, pageSize];
}

@lazySingleton
class GetNotifications implements UseCase<NotificationsPage, GetNotificationsParams> {
  const GetNotifications(this._repository);

  final NotificationsRepository _repository;

  @override
  Future<Either<Failure, NotificationsPage>> call(GetNotificationsParams params) {
    return _repository.getNotifications(page: params.page, pageSize: params.pageSize);
  }
}
