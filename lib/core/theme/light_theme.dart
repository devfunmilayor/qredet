import 'package:flutter/material.dart';
import 'package:qredet/core/theme/app_colors.dart';
import 'package:qredet/core/theme/app_semantic_colors.dart';

ThemeData buildLightTheme() {
  final semantic = AppSemanticColors.light();
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: semantic.surfaceBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryPurple,
      brightness: Brightness.light,
      primary: semantic.primary,
      error: semantic.error,
      surface: semantic.surfaceBackground,
    ),
    extensions: [semantic],
    dividerColor: semantic.divider,
    fontFamily: 'Mona Sans',
  );
}
