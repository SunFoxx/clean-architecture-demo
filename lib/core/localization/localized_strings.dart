/// Carcass for holding every string in the app
/// Whereas the app becomes bigger and bigger, the monolith of String getters semantically divided into
/// multiple subclasses for better readability
abstract class LocalizedStrings
    implements CommonStrings, MakesStrings, ManufacturerStrings, ErrorStrings {}

abstract class CommonStrings {
  String get tryAgain;
}

abstract class ManufacturerStrings {
  String get noManufacturersMessage;
}

abstract class MakesStrings {
  String get backToManufacturersButtonText;

  String get noMakesMessage;
}

abstract class ErrorStrings {
  String get cacheErrorMessage;

  String get unexpectedErrorMessage;

  String get serverErrorMessagePart;

  String get badConnectivityErrorMessage;
}
