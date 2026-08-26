import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(AppSpacing.pillRadius);
    final isDisabled = onPressed == null && !isLoading;

    if (isOutlined) {
      return AnimatedOpacity(
        opacity: isDisabled ? 0.5 : 1,
        duration: const Duration(milliseconds: 150),
        child: SizedBox(
          height: 56,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colors.divider),
              shape: RoundedRectangleBorder(borderRadius: radius),
            ),
            child: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primary,
                    ),
                  )
                : Text(
                    label,
                    style: AppTextStyles.buttonLabel.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
          ),
        ),
      );
    }

    return AnimatedOpacity(
      opacity: isDisabled ? 0.5 : 1,
      duration: const Duration(milliseconds: 150),
      child: SizedBox(
        height: 56,
        child: Stack(
          children: [
            Positioned.fill(
              top: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.primaryPressed,
                  borderRadius: radius,
                ),
              ),
            ),
            Positioned.fill(
              bottom: 4,
              child: Material(
                color: colors.primary,
                borderRadius: radius,
                child: InkWell(
                  onTap: isLoading ? null : onPressed,
                  borderRadius: radius,
                  child: Center(
                    child: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.textOnPrimary,
                            ),
                          )
                        : Text(
                            label,
                            style: AppTextStyles.buttonLabel.copyWith(
                              color: colors.textOnPrimary,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
