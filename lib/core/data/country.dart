import 'package:equatable/equatable.dart';

/// A dialing-code entry for the Auth phone-number field's country picker.
class Country extends Equatable {
  const Country({
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.phoneNumberLength,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['country_name'] as String,
        dialCode: json['country_code'] as String,
        flag: json['flag'] as String,
        phoneNumberLength: json['phone_number_length'] as int,
      );

  final String name;
  final String dialCode;
  final String flag;
  final int phoneNumberLength;

  @override
  List<Object?> get props => [name, dialCode, flag, phoneNumberLength];
}
