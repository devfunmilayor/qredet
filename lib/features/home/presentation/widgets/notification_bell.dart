import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_semantic_colors.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, this.hasUnread = false, this.onTap});

  final bool hasUnread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: colors.surfaceAvatar, shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications_outlined, color: colors.textPrimary, size: 20),
            if (hasUnread)
              Positioned(
                top: 10,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: colors.error, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
