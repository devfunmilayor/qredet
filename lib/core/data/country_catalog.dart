import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../gen/assets.gen.dart';
import 'country.dart';

/// Loads the static dial-code catalog bundled at [Assets.data.countries].
/// Kept as a JSON asset rather than a generated Dart file so the 190+ row
/// dataset can be swapped without touching code.
Future<List<Country>> loadCountries() async {
  final raw = await rootBundle.loadString(Assets.data.countries);
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  final entries = decoded['list_of_country'] as List<dynamic>;
  return entries.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
}
