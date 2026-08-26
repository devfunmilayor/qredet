import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/language_bloc.dart';
import '../bloc/language_state.dart';
import 'language_sheet.dart';

class LanguagePill extends StatelessWidget {
  const LanguagePill({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is! LanguageLoaded) return const SizedBox.shrink();
        return InkWell(
          onTap: () => LanguageSheet.show(context),
          borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: colors.chipBackground,
              borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.selected.flagEmoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  state.selected.code.toUpperCase(),
                  style: AppTextStyles.pillLabel.copyWith(color: colors.textPrimary),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
