import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/features/language/presentation/bloc/language_bloc.dart';
import 'package:qredet/features/language/presentation/bloc/language_state.dart';
import 'package:qredet/features/language/presentation/widgets/language_sheet.dart';

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
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.chipBackground,
              borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.selected.flagEmoji,
                  style: const TextStyle(fontSize: 18.5),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  state.selected.label,
                  style: AppTextStyles.pillLabel.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: colors.textMuted,
                  size: 20,
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 250.ms);
      },
    );
  }
}
