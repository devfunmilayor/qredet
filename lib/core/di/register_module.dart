import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../network/dio_client.dart';

/// Registers plain (non-annotated) instances with the service locator.
/// Feature modules register their own repositories/data sources via
/// `@injectable`/`@LazySingleton` on the classes themselves.
@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => buildDioClient();
}
