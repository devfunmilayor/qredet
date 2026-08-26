import 'package:injectable/injectable.dart';
import '../../../core/config/app_config.dart';
import 'datasources/home_data_source.dart';
import 'datasources/home_http_data_source.dart';
import 'datasources/home_mock_data_source.dart';

@module
abstract class HomeModule {
  @lazySingleton
  HomeDataSource dataSource(HomeMockDataSource mock, HomeHttpDataSource http) =>
      AppConfig.useMockHomeData ? mock : http;
}
