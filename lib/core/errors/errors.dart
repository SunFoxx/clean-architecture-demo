import 'package:dio/dio.dart';

part 'cache_errors.dart';
part 'network_errors.dart';

class UnexpectedError implements Exception {
  final String? message;

  const UnexpectedError([this.message]);

  @override
  String toString() {
    return 'UnexpectedError: $message';
  }
}
