import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => buildDioClient();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
