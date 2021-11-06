import 'package:jimmy_test/core/localization/localized_strings.dart';

class EnErrorStrings implements ErrorStrings {
  @override
  String get badConnectivityErrorMessage =>
      'Bad connectivity: check the internet connection status';

  @override
  String get cacheErrorMessage =>
      'Unable to find any data locally. Please, restore the internet connection and try again';

  @override
  String get serverErrorMessagePart => 'Server responded with following error:';

  @override
  String get unexpectedErrorMessage => 'Unexpected error. Something went wrong during the loading';
}
