import 'package:flutter/material.dart';
import 'package:qredet/core/theme/app_colors.dart';
import 'package:qredet/core/theme/app_semantic_colors.dart';

ThemeData buildDarkTheme() {
  final semantic = AppSemanticColors.dark();
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: semantic.surfaceBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimaryPurple,
      brightness: Brightness.dark,
      primary: semantic.primary,
      error: semantic.error,
      surface: semantic.surfaceBackground,
    ),
    extensions: [semantic],
    dividerColor: semantic.divider,
    fontFamily: 'Mona Sans',
  );
}
