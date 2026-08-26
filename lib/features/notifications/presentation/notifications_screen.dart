import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';
import '../data/notification_catalog.dart';
import 'widgets/notification_tile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.notifications)),
      body: notificationCatalog.isEmpty
          ? StatePlaceholder(icon: Icons.notifications_none, title: l10n.noNotificationsYet)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: AppSpacing.md),
              itemCount: notificationCatalog.length,
              itemBuilder: (context, index) {
                return NotificationTile(notification: notificationCatalog[index])
                    .animate(delay: (40 * index).ms)
                    .fadeIn(duration: 250.ms)
                    .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
              },
            ),
    );
  }
}
