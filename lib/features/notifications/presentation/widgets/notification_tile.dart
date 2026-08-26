import 'package:flutter/material.dart';
import '../../../../core/formatters/formatters.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/notification_item.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
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
            child: Icon(Icons.notifications_outlined, color: colors.textPrimary, size: 18),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title, style: AppTextStyles.tileAlias.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 2),
                Text(notification.body, style: AppTextStyles.cardSubtitle.copyWith(color: colors.textMuted)),
                const SizedBox(height: 4),
                Text(
                  formatTransactionDate(notification.timestamp, locale: locale),
                  style: AppTextStyles.tileDate.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
