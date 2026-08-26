import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_semantic_colors.dart';

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
