import 'package:dio/dio.dart';

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
    _dioClient.interceptors.addAll([]);
  }
}
