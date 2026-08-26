import 'package:flutter/material.dart';
import '../theme/theme.dart';

const _keypadRows = [
  ['1', '2', '3'],
  ['4', '5', '6'],
  ['7', '8', '9'],
  ['', '0', 'backspace'],
];

class PinKeypad extends StatelessWidget {
  const PinKeypad({super.key, required this.onDigit, required this.onBackspace});

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in _keypadRows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [for (final key in row) _KeypadKey(value: key, onDigit: onDigit, onBackspace: onBackspace)],
            ),
          ),
      ],
    );
  }
}

class _KeypadKey extends StatelessWidget {
  const _KeypadKey({required this.value, required this.onDigit, required this.onBackspace});

  final String value;
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox(width: 64, height: 56);
    final colors = context.colors;
    final isBackspace = value == 'backspace';
    return SizedBox(
      width: 64,
      height: 56,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.md),
          onTap: isBackspace ? onBackspace : () => onDigit(value),
          child: Center(
            child: isBackspace
                ? Icon(Icons.backspace_outlined, color: colors.textPrimary, size: 22)
                : Text(value, style: AppTextStyles.sheetTitle.copyWith(color: colors.textPrimary)),
          ),
        ),
      ),
    );
  }
}
