import 'package:dio/dio.dart';
import 'package:qredet/core/error/exception_mapper.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = mapExceptionToFailure(err);
    handler.next(err.copyWith(error: failure));
  }
}
