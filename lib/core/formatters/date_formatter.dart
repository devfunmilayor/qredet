import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Renders transaction timestamps as `21 May 2025 • 4:01 PM`, locale-aware.
String formatTransactionDate(DateTime dateTime, {required Locale locale}) {
  final formatter = DateFormat('d MMM y • h:mm a', locale.toLanguageTag());
  return formatter.format(dateTime);
}
