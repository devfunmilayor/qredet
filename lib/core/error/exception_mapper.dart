import 'package:dio/dio.dart';
import 'failure.dart';


Failure mapExceptionToFailure(Object error) {
  if (error is DioException) return _mapDioException(error);
  if (error is Failure) return error;
  return Failure.unknown(error.toString());
}

Failure _mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const Failure.timeout();
    case DioExceptionType.connectionError:
      return const Failure.network();
    case DioExceptionType.badResponse:
      return Failure.server(error.response?.statusMessage);
    case DioExceptionType.cancel:
      return const Failure.unknown('Request was cancelled');
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return Failure.unknown(error.message);
  }
}
