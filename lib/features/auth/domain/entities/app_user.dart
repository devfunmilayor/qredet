import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({required this.uid, this.email, required this.isAnonymous});

  final String uid;
  final String? email;
  final bool isAnonymous;

  @override
  List<Object?> get props => [uid, email, isAnonymous];
}
