import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.primary,
    required this.primaryPressed,
    required this.chipBackground,
    required this.textNavy,
    required this.textPrimary,
    required this.textMuted,
    required this.textOnPrimary,
    required this.surfaceCard,
    required this.surfaceAvatar,
    required this.surfaceBackground,
    required this.divider,
    required this.error,
    required this.brandCream,
  });

  final Color primary;
  final Color primaryPressed;
  final Color chipBackground;
  final Color textNavy;
  final Color textPrimary;
  final Color textMuted;
  final Color textOnPrimary;
  final Color surfaceCard;
  final Color surfaceAvatar;
  final Color surfaceBackground;
  final Color divider;
  final Color error;
  final Color brandCream;

  factory AppSemanticColors.light() => const AppSemanticColors(
        primary: AppColors.primaryPurple,
        primaryPressed: AppColors.primaryPurplePressed,
        chipBackground: AppColors.chipBackground,
        textNavy: AppColors.textNavy,
        textPrimary: AppColors.textPrimary,
        textMuted: AppColors.textMuted,
        textOnPrimary: AppColors.textOnPrimary,
        surfaceCard: AppColors.surfaceCard,
        surfaceAvatar: AppColors.surfaceAvatar,
        surfaceBackground: AppColors.surfaceBackground,
        divider: AppColors.divider,
        error: AppColors.error,
        brandCream: AppColors.brandCream,
      );

  factory AppSemanticColors.dark() => const AppSemanticColors(
        primary: AppColors.darkPrimaryPurple,
        primaryPressed: AppColors.primaryPurple,
        chipBackground: AppColors.darkChipBackground,
        textNavy: AppColors.darkTextPrimary,
        textPrimary: AppColors.darkTextPrimary,
        textMuted: AppColors.darkTextMuted,
        textOnPrimary: AppColors.darkTextPrimary,
        surfaceCard: AppColors.darkSurfaceCard,
        surfaceAvatar: AppColors.darkSurfaceAvatar,
        surfaceBackground: AppColors.darkBackground,
        divider: AppColors.darkDivider,
        error: AppColors.darkError,
        brandCream: AppColors.brandCream,
      );

  @override
  AppSemanticColors copyWith({
    Color? primary,
    Color? primaryPressed,
    Color? chipBackground,
    Color? textNavy,
    Color? textPrimary,
    Color? textMuted,
    Color? textOnPrimary,
    Color? surfaceCard,
    Color? surfaceAvatar,
    Color? surfaceBackground,
    Color? divider,
    Color? error,
    Color? brandCream,
  }) {
    return AppSemanticColors(
      primary: primary ?? this.primary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      chipBackground: chipBackground ?? this.chipBackground,
      textNavy: textNavy ?? this.textNavy,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textOnPrimary: textOnPrimary ?? this.textOnPrimary,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceAvatar: surfaceAvatar ?? this.surfaceAvatar,
      surfaceBackground: surfaceBackground ?? this.surfaceBackground,
      divider: divider ?? this.divider,
      error: error ?? this.error,
      brandCream: brandCream ?? this.brandCream,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      textNavy: Color.lerp(textNavy, other.textNavy, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textOnPrimary: Color.lerp(textOnPrimary, other.textOnPrimary, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceAvatar: Color.lerp(surfaceAvatar, other.surfaceAvatar, t)!,
      surfaceBackground: Color.lerp(surfaceBackground, other.surfaceBackground, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      error: Color.lerp(error, other.error, t)!,
      brandCream: Color.lerp(brandCream, other.brandCream, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppSemanticColors get colors => Theme.of(this).extension<AppSemanticColors>()!;
}
