import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_semantic_colors.dart';

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
