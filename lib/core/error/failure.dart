import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Every usecase returns `Either<Failure, T>` instead of throwing, and the
/// UI picks its copy and icon from which variant it gets back.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.network() = NetworkFailure;
  const factory Failure.server([String? message]) = ServerFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.unknown([String? message]) = UnknownFailure;
}
