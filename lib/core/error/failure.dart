import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';


@freezed
sealed class Failure with _$Failure {
  const factory Failure.network() = NetworkFailure;
  const factory Failure.server([String? message]) = ServerFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.unknown([String? message]) = UnknownFailure;
}
