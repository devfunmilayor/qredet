import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qredet/core/formatters/currency_formatter.dart';

void main() {
  test('formatCurrency renders grouped digits with an F suffix', () {
    expect(formatCurrency(10000, locale: const Locale('en')), '10,000 F');
  });

  test('formatAmount omits the suffix', () {
    expect(formatAmount(1000, locale: const Locale('en')), '1,000');
  });
}
