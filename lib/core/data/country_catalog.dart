import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../gen/assets.gen.dart';
import 'country.dart';

Future<List<Country>> loadCountries() async {
  final raw = await rootBundle.loadString(Assets.data.countries);
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  final entries = decoded['list_of_country'] as List<dynamic>;
  return entries.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
}
