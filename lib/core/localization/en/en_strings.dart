import 'package:jimmy_test/core/localization/en/strings/common.dart';
import 'package:jimmy_test/core/localization/en/strings/errors.dart';
import 'package:jimmy_test/core/localization/en/strings/makes.dart';
import 'package:jimmy_test/core/localization/en/strings/manufacturers.dart';
import 'package:jimmy_test/core/localization/localized_strings.dart';

class EnStrings
    with EnErrorStrings, EnCommonStrings, EnManufacturersStrings, EnMakesStrings
    implements LocalizedStrings {}
