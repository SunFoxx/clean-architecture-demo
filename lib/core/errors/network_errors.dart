part of 'errors.dart';

/// Currently, these errors adapted to fit [Dio] package since it allows us to handle them inside interceptors
/// It doesn't break anything since [DioError] extends Exception by itself

class BadConnectionError extends DioError {
  BadConnectionError(RequestOptions options) : super(requestOptions: options);

  @override
  String toString() {
    return 'Bad connectivity: check the internet connection status';
  }
}

class ServerError extends DioError {
  ServerError(RequestOptions requestOptions) : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'ServerError: $message';
  }
}
