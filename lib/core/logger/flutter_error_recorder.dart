import 'package:flutter/foundation.dart';

/// Class for handling all the errors occurred in the flutter
/// Not doing much for now, but can potentially send errors to external error-tracking SDK's
class FlutterErrorRecorder {
  static Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails) async {
    return FlutterError.presentError(flutterErrorDetails);
  }
}
