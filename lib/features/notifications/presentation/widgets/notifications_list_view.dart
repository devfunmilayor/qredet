import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:qredet/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:qredet/features/notifications/presentation/widgets/notification_tile.dart';

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({super.key, required this.state});

  final NotificationsState state;

  @override
  State<NotificationsListView> createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsBloc>().add(
        const NotificationsEvent.moreRequested(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.state.items;
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.md,
      ),
      itemCount: items.length + (widget.state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final notification = items[index];
        return NotificationTile(
              notification: notification,
              onDelete: () => context.read<NotificationsBloc>().add(
                NotificationsEvent.deleted(notification.id),
              ),
              onMarkRead: () => context.read<NotificationsBloc>().add(
                NotificationsEvent.markedRead(notification.id),
              ),
            )
            .animate(delay: (30 * index).ms)
            .fadeIn(duration: 200.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
      },
    );
  }
}
