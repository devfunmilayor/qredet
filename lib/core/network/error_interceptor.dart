import 'package:dio/dio.dart';
import '../error/exception_mapper.dart';


class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = mapExceptionToFailure(err);
    handler.next(err.copyWith(error: failure));
  }
}
