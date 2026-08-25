import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../network/dio_client.dart';
import '../storage/hive_boxes.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => buildDioClient();

  @preResolve
  Future<Box<String>> get settingsBox => Hive.openBox<String>(HiveBoxes.settings);

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
