import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppToast {
  const AppToast._();

  static void showSuccess(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) =>
          _AppToastView(message: message, color: AppColors.toastSuccess),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 2200), entry.remove);
  }
}

class _AppToastView extends StatelessWidget {
  const _AppToastView({required this.message, required this.color});

  final String message;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppSpacing.screenHorizontal,
      right: AppSpacing.screenHorizontal,
      top: 96,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child:
              Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.pillRadius,
                      ),
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.buttonLabel.copyWith(
                        color: Colors.white,
                        fontSize: 11.5,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 200.ms)
                  .slideY(
                    begin: 0.3,
                    end: 0,
                    duration: 250.ms,
                    curve: Curves.easeOut,
                  )
                  .then(delay: 1700.ms)
                  .fadeOut(duration: 300.ms),
        ),
      ),
    );
  }
}
