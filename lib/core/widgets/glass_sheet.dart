import 'dart:ui';
import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/app_semantic_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class GlassSheet extends StatelessWidget {
  const GlassSheet({super.key, required this.title, required this.child, required this.onCancel});

  final String title;
  final Widget child;
  final VoidCallback onCancel;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.65;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.sheetRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            decoration: BoxDecoration(color: colors.surfaceCard.withValues(alpha: 0.85)),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppTextStyles.sheetTitle.copyWith(color: colors.textPrimary)),
                      TextButton(onPressed: onCancel, child: Text(AppLocalizations.of(context).cancel)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Flexible(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
