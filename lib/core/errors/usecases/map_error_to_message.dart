import 'package:equatable/equatable.dart';
import 'package:jimmy_test/core/entities/usecase.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';

/// This usecase maps all known error types into error messages
/// that are readable by end users within UI.
/// It is capable of overriding default messages through the [ErrorMessageMapperParameters]
class MapErrorToMessage implements UseCase<String, ErrorMessageMapperParameters> {
  final StringProvider _stringProvider;

  MapErrorToMessage(this._stringProvider);

  @override
  Future<String> call(ErrorMessageMapperParameters params) {
    final strings = _stringProvider.strings;
    final exception = params.error;

    getMessageByType() {
      if (exception is ServerError) {
        return params.serverErrorMessage ??
            '${strings.serverErrorMessagePart} ${exception.toString()}';
      }

      if (exception is BadConnectionError) {
        return params.badConnectivityErrorMessage ?? strings.badConnectivityErrorMessage;
      }

      if (exception is CacheError) {
        return params.cacheErrorMessage ?? strings.cacheErrorMessage;
      }

      return params.unexpectedErrorMessage ?? strings.unexpectedErrorMessage;
    }

    return Future.value(getMessageByType());
  }
}

class ErrorMessageMapperParameters extends Equatable {
  final Exception error;
  final String? serverErrorMessage;
  final String? badConnectivityErrorMessage;
  final String? cacheErrorMessage;
  final String? unexpectedErrorMessage;

  const ErrorMessageMapperParameters({
    required this.error,
    this.serverErrorMessage,
    this.badConnectivityErrorMessage,
    this.cacheErrorMessage,
    this.unexpectedErrorMessage,
  });

  @override
  List<Object?> get props => [
        error,
        serverErrorMessage,
        badConnectivityErrorMessage,
        cacheErrorMessage,
        unexpectedErrorMessage,
      ];
}
