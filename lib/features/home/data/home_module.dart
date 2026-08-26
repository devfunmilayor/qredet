import 'package:injectable/injectable.dart';
import 'package:qredet/core/config/app_config.dart';
import 'package:qredet/features/home/data/datasources/home_data_source.dart';
import 'package:qredet/features/home/data/datasources/home_http_data_source.dart';
import 'package:qredet/features/home/data/datasources/home_mock_data_source.dart';

@module
abstract class HomeModule {
  @lazySingleton
  HomeDataSource dataSource(HomeMockDataSource mock, HomeHttpDataSource http) =>
      AppConfig.useMockHomeData ? mock : http;
}
