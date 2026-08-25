import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Renders wallet amounts as grouped digits with a trailing "F" suffix
/// (Franc-denominated wallet), e.g. `10.000F`. No decimals: the wallet
/// only ever deals in whole-unit amounts.
String formatCurrency(num amount, {required Locale locale}) {
  final formatter = NumberFormat.decimalPattern(locale.toLanguageTag())
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 0;
  return '${formatter.format(amount)}F';
}
