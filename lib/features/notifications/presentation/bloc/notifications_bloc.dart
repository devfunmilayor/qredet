import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/usecases/delete_notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_read.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

const _pageSize = 8;

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(
    this._getNotifications,
    this._deleteNotification,
    this._markNotificationRead,
  ) : super(const NotificationsState()) {
    on<NotificationsStarted>(_onStarted);
    on<NotificationsMoreRequested>(_onMoreRequested);
    on<NotificationDeleted>(_onDeleted);
    on<NotificationMarkedRead>(_onMarkedRead);
  }

  final GetNotifications _getNotifications;
  final DeleteNotification _deleteNotification;
  final MarkNotificationRead _markNotificationRead;
  int _page = 1;

  Future<void> _onStarted(
    NotificationsStarted event,
    Emitter<NotificationsState> emit,
  ) async {
    _page = 1;
    emit(state.copyWith(status: NotificationsStatus.loading));
    final result = await _getNotifications(
      const GetNotificationsParams(page: 1, pageSize: _pageSize),
    );
    result.match(
      (failure) => emit(state.copyWith(status: NotificationsStatus.error)),
      (page) => emit(
        state.copyWith(
          status: NotificationsStatus.loaded,
          items: page.items,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> _onMoreRequested(
    NotificationsMoreRequested event,
    Emitter<NotificationsState> emit,
  ) async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getNotifications(
      GetNotificationsParams(page: _page + 1, pageSize: _pageSize),
    );
    result.match((failure) => emit(state.copyWith(isLoadingMore: false)), (
      page,
    ) {
      _page++;
      emit(
        state.copyWith(
          items: [...state.items, ...page.items],
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      );
    });
  }

  Future<void> _onDeleted(
    NotificationDeleted event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await _deleteNotification(event.id);
    result.match(
      (failure) {},
      (_) => emit(
        state.copyWith(
          items: state.items.where((item) => item.id != event.id).toList(),
        ),
      ),
    );
  }

  Future<void> _onMarkedRead(
    NotificationMarkedRead event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await _markNotificationRead(event.id);
    result.match(
      (failure) {},
      (_) => emit(
        state.copyWith(
          items: [
            for (final item in state.items)
              if (item.id == event.id)
                NotificationItem(
                  id: item.id,
                  type: item.type,
                  timestamp: item.timestamp,
                  isRead: true,
                )
              else
                item,
          ],
        ),
      ),
    );
  }
}
