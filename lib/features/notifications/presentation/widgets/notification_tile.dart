import 'package:flutter/material.dart';
import 'package:qredet/core/formatters/formatters.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/features/notifications/domain/entities/notification_item.dart';

extension NotificationTypeLabels on NotificationType {
  String title(AppLocalizations l10n) => switch (this) {
    NotificationType.paymentReceived => l10n.notifTitlePaymentReceived,
    NotificationType.paymentSent => l10n.notifTitlePaymentSent,
    NotificationType.upgradeAvailable => l10n.notifTitleUpgradeAvailable,
    NotificationType.securityAlert => l10n.notifTitleSecurityAlert,
    NotificationType.weeklySummary => l10n.notifTitleWeeklySummary,
  };

  String body(AppLocalizations l10n) => switch (this) {
    NotificationType.paymentReceived => l10n.notifBodyPaymentReceived,
    NotificationType.paymentSent => l10n.notifBodyPaymentSent,
    NotificationType.upgradeAvailable => l10n.notifBodyUpgradeAvailable,
    NotificationType.securityAlert => l10n.notifBodySecurityAlert,
    NotificationType.weeklySummary => l10n.notifBodyWeeklySummary,
  };
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDelete,
    required this.onMarkRead,
  });

  final NotificationItem notification;
  final VoidCallback onDelete;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification.id),
      direction: notification.isRead
          ? DismissDirection.endToStart
          : DismissDirection.horizontal,
      background: _SwipeBackground(
        alignStart: true,
        color: Colors.green,
        icon: Icons.done_all,
      ),
      secondaryBackground: _SwipeBackground(
        alignStart: false,
        color: Colors.redAccent,
        icon: Icons.delete_outline,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onMarkRead();
          return false;
        }
        return true;
      },
      onDismissed: (_) => onDelete(),
      child: _NotificationTileContent(notification: notification),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.alignStart,
    required this.color,
    required this.icon,
  });

  final bool alignStart;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignStart ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _NotificationTileContent extends StatelessWidget {
  const _NotificationTileContent({required this.notification});

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.transparent : colors.chipBackground,
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: colors.surfaceAvatar,
            child: Icon(
              Icons.notifications_outlined,
              color: colors.textPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.type.title(l10n),
                  style: AppTextStyles.tileAlias.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notification.type.body(l10n),
                  style: AppTextStyles.cardSubtitle.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatTransactionDate(notification.timestamp, locale: locale),
                  style: AppTextStyles.tileDate.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
