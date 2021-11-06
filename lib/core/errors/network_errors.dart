part of 'errors.dart';

/// Currently, these errors adapted to fit [Dio] package since it allows us to handle them inside interceptors
/// It doesn't break anything since [DioError] extends Exception by itself
/// And we do not need to import dio everywhere and increase coupling with it wherever we use these errors

class BadConnectionError extends DioError {
  BadConnectionError(RequestOptions options) : super(requestOptions: options);

  @override
  String toString() {
    return 'Bad connectivity: check the internet connection status';
  }
}

class ServerError extends DioError {
  ServerError(RequestOptions requestOptions) : super(requestOptions: requestOptions);

  ServerError.fromDioError(DioError error)
      : super(
          requestOptions: error.requestOptions,
          response: error.response,
          error: error.error,
          type: error.type,
        );

  @override
  String toString() {
    final messageString = response?.statusMessage ?? message;
    return 'Server error${messageString.isNotEmpty ? ': $messageString' : ''}';
  }
}
