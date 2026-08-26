import 'package:injectable/injectable.dart';
import 'package:qredet/core/config/app_config.dart';
import 'package:qredet/features/auth/data/datasources/auth_data_source.dart';
import 'package:qredet/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:qredet/features/auth/data/datasources/auth_mock_data_source.dart';

@module
abstract class AuthModule {
  @lazySingleton
  AuthDataSource dataSource(
    AuthMockDataSource mock,
    AuthFirebaseDataSource firebase,
  ) => AppConfig.useMockAuth ? mock : firebase;
}
