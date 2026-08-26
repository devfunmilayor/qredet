import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/glass_sheet.dart';
import '../bloc/language_bloc.dart';
import '../bloc/language_event.dart';
import '../bloc/language_state.dart';
import 'language_tile.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  static Future<void> show(BuildContext context) {
    final bloc = context.read<LanguageBloc>();
    return GlassSheet.show(
      context,
      builder: (_) => BlocProvider.value(value: bloc, child: const LanguageSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is! LanguageLoaded) return const SizedBox.shrink();
        return GlassSheet(
          title: AppLocalizations.of(context).selectLanguage,
          onCancel: () => Navigator.of(context).pop(),
          child: ListView.builder(
            itemCount: state.languages.length,
            itemBuilder: (context, index) {
              final language = state.languages[index];
              return LanguageTile(
                language: language,
                selected: language.code == state.selected.code,
                onTap: () {
                  context.read<LanguageBloc>().add(LanguageEvent.changed(language));
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }
}
