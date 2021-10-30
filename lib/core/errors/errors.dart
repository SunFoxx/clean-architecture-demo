class NoConnectionError implements Exception {}

class ServerError implements Exception {
  final String? message;

  ServerError([this.message]);
}

class UnexpectedError implements Exception {
  final String? message;

  UnexpectedError([this.message]);
}
