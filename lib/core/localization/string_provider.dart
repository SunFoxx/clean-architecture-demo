import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'localized_strings.dart';

class StringProvider extends ChangeNotifier {
  LocalizedStrings _localizedStrings;

  StringProvider(this._localizedStrings);

  void setupLocalizedStrings(LocalizedStrings localizedStrings) {
    _localizedStrings = localizedStrings;
    notifyListeners();
  }

  LocalizedStrings get strings => _localizedStrings;
}

extension WithContext on BuildContext {
  StringProvider stringProvider({bool? listen}) =>
      Provider.of<StringProvider>(this, listen: listen ?? true);

  LocalizedStrings localizedStrings({bool? listen}) =>
      Provider.of<StringProvider>(this, listen: listen ?? true).strings;
}
