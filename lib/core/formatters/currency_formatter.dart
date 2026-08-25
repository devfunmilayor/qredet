import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


String formatCurrency(num amount, {required Locale locale}) {
  final formatter = NumberFormat.decimalPattern(locale.toLanguageTag())
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 0;
  return '${formatter.format(amount)}F';
}
