import 'failure.dart';

extension FailureMessage on Failure {
  String get userMessage => switch (this) {
        NetworkFailure() => 'No internet connection',
        TimeoutFailure() => 'Request timed out',
        ServerFailure(:final message) => message ?? 'Something went wrong',
        UnknownFailure(:final message) => message ?? 'Something went wrong',
      };
}
