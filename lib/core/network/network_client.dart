import 'package:dio/dio.dart';
import 'package:jimmy_test/core/network/interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Wrapper around Dio client for streamlining its configuration
class VehiclesApiClient {
  static const _BASE_URL = 'https://vpic.nhtsa.dot.gov/api';

  final Dio _dioClient = Dio();

  Dio get client => _dioClient;

  BaseOptions get _options => BaseOptions(
        baseUrl: _BASE_URL,
        connectTimeout: 5000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
      );

  void configureVehiclesApiClient() {
    _dioClient.options = _options;
    _dioClient.interceptors.addAll([
      BadNetworkErrorInterceptor(),
      PrettyDioLogger(requestBody: true),
    ]);
  }
}
