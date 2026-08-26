import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import 'bloc/notifications_bloc.dart';
import 'bloc/notifications_event.dart';
import 'bloc/notifications_state.dart';
import 'widgets/notification_tile_shimmer.dart';
import 'widgets/notifications_list_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<NotificationsBloc>()..add(const NotificationsEvent.started()),
      child: const _NotificationsScreenBody(),
    );
  }
}

class _NotificationsScreenBody extends StatelessWidget {
  const _NotificationsScreenBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifications)),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          return switch (state.status) {
            NotificationsStatus.loading => const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: AppSpacing.md,
              ),
              child: NotificationTileShimmer(),
            ),
            NotificationsStatus.error => StatePlaceholder(
              icon: Icons.error_outline,
              title: l10n.transactionsErrorTitle,
              subtitle: l10n.tryAgainMessage,
              retryLabel: l10n.retry,
              onRetry: () => context.read<NotificationsBloc>().add(
                const NotificationsEvent.started(),
              ),
            ),
            NotificationsStatus.loaded when state.items.isEmpty =>
              StatePlaceholder(
                icon: Icons.notifications_none,
                title: l10n.noNotificationsYet,
              ),
            NotificationsStatus.loaded => NotificationsListView(state: state),
          };
        },
      ),
    );
  }
}
