import 'package:injectable/injectable.dart';
import '../../../core/config/app_config.dart';
import 'datasources/auth_data_source.dart';
import 'datasources/auth_firebase_data_source.dart';
import 'datasources/auth_mock_data_source.dart';

@module
abstract class AuthModule {
  @lazySingleton
  AuthDataSource dataSource(
    AuthMockDataSource mock,
    AuthFirebaseDataSource firebase,
  ) => AppConfig.useMockAuth ? mock : firebase;
}
