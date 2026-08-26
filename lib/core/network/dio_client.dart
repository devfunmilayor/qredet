import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'error_interceptor.dart';

const String _baseUrl = 'https://api.qredet.dev';

Dio buildDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(ErrorInterceptor());

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
}
