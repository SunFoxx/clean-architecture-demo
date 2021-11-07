import 'package:jimmy_test/core/localization/localized_strings.dart';

class EnMakesStrings implements MakesStrings {
  @override
  String get noMakesMessage => 'We were unable to find any makes for that manufacturer :(';

  @override
  String get backToManufacturersButtonText => 'Back to list';
}
