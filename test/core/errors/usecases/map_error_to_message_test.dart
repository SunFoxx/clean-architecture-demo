import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/core/localization/localized_strings.dart';
import 'package:jimmy_test/core/localization/string_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'map_error_to_message_test.mocks.dart';

@GenerateMocks([StringProvider, LocalizedStrings])
main() {
  late MapErrorToMessage mapErrorToMessage;
  late MockStringProvider stringProvider;
  late MockLocalizedStrings localizedStrings;

  const tBadConnectionErrorMessage = 'Bad connection error test';
  const tServerErrorMessagePart = 'Server error test';
  const tCacheErrorMessage = 'Cache error test';
  const tServerErrorRemoteMessage = 'Some unreadable to user error text';
  const tUnexpectedErrorMessage = 'Unexpected error test';

  final tBadConnectionError = BadConnectionError(RequestOptions(path: ''));
  final tServerError = ServerError.fromDioError(DioError(
    requestOptions: RequestOptions(path: ''),
    error: tServerErrorRemoteMessage,
  ));
  final tCacheError = CacheError();
  const tUnexpectedError = UnexpectedError();
  final tAllErrors = [tBadConnectionError, tServerError, tCacheError, tUnexpectedError];

  setUp(() {
    localizedStrings = MockLocalizedStrings();
    stringProvider = MockStringProvider();
    mapErrorToMessage = MapErrorToMessage(stringProvider);

    when(stringProvider.strings).thenReturn(localizedStrings);
  });

  /// Helper function to get error messages for all declared errors and put them into dictionary
  /// passed parameter is a function that generates the parameters for every error usecase call
  Future<Map<Exception, String>> getMessagesForAllErrors(
      ErrorMessageMapperParameters Function(Exception error) getParams) async {
    return {for (var error in tAllErrors) error: await mapErrorToMessage(getParams(error))};
  }

  test('should return default message from localizedStrings when no param message provided',
      () async {
    // arrange
    when(localizedStrings.cacheErrorMessage).thenReturn(tCacheErrorMessage);
    when(localizedStrings.badConnectivityErrorMessage).thenReturn(tBadConnectionErrorMessage);
    when(localizedStrings.serverErrorMessagePart).thenReturn(tServerErrorMessagePart);
    when(localizedStrings.unexpectedErrorMessage).thenReturn(tUnexpectedErrorMessage);

    // act
    final resultsMap =
        await getMessagesForAllErrors((error) => ErrorMessageMapperParameters(error: error));

    // assert
    expect(resultsMap[tUnexpectedError], tUnexpectedErrorMessage);
    expect(resultsMap[tBadConnectionError], tBadConnectionErrorMessage);
    expect(resultsMap[tCacheError], tCacheErrorMessage);
    expect(resultsMap[tServerError], '$tServerErrorMessagePart ${tServerError.toString()}');
  });

  test('should override default messages when custom messages passed to the parameters', () async {
    // arrange
    // act
    final resultsMap = await getMessagesForAllErrors((error) => ErrorMessageMapperParameters(
          error: error,
          serverErrorMessage: tServerErrorRemoteMessage,
          badConnectivityErrorMessage: tBadConnectionErrorMessage,
          cacheErrorMessage: tCacheErrorMessage,
          unexpectedErrorMessage: tUnexpectedErrorMessage,
        ));

    // assert
    expect(resultsMap[tUnexpectedError], tUnexpectedErrorMessage);
    expect(resultsMap[tBadConnectionError], tBadConnectionErrorMessage);
    expect(resultsMap[tCacheError], tCacheErrorMessage);
    expect(resultsMap[tServerError], tServerErrorRemoteMessage);
    verifyNever(localizedStrings.cacheErrorMessage);
    verifyNever(localizedStrings.badConnectivityErrorMessage);
    verifyNever(localizedStrings.serverErrorMessagePart);
    verifyNever(localizedStrings.unexpectedErrorMessage);
  });
}
