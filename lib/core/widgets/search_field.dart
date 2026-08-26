import 'package:flutter/material.dart';
import '../theme/app_semantic_colors.dart';
import 'app_text_field.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppTextField(
      label: hint,
      controller: controller,
      onChanged: onChanged,
      prefixIcon: Icon(Icons.search, color: colors.textMuted),
      suffixIcon: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, _) {
          if (value.text.isEmpty) return const SizedBox.shrink();
          return IconButton(
            icon: Icon(Icons.close, color: colors.textMuted),
            onPressed: () {
              controller.clear();
              onChanged?.call('');
            },
          );
        },
      ),
    );
  }
}
