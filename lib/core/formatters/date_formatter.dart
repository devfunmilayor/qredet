import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatTransactionDate(DateTime dateTime, {required Locale locale}) {
  final formatter = DateFormat('d MMM y • h:mm a', locale.toLanguageTag());
  return formatter.format(dateTime);
}
