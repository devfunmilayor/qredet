import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Grouped digits only, no suffix — for callers that style the "F" suffix
/// separately (e.g. the balance header's large-amount/small-suffix pairing).
String formatAmount(num amount, {required Locale locale}) {
  final formatter = NumberFormat.decimalPattern(locale.toLanguageTag())
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 0;
  return formatter.format(amount);
}

/// Full "1.000 F" wallet-amount string. No decimals: the wallet only ever
/// deals in whole-unit amounts.
String formatCurrency(num amount, {required Locale locale}) {
  return '${formatAmount(amount, locale: locale)} F';
}
