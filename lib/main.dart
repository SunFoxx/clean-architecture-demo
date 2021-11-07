import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jimmy_test/app.dart';
import 'package:jimmy_test/core/locator.dart';
import 'package:jimmy_test/core/logger/flutter_error_recorder.dart';
import 'package:jimmy_test/core/logger/logger.dart';
import 'package:jimmy_test/core/logger/logging_bloc_observer.dart';
import 'package:jimmy_test/core/utils/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await HiveUtils.initHive();
  Bloc.observer = LoggingBlocObserver();
  FlutterError.onError = FlutterErrorRecorder.recordFlutterError;

  runZonedGuarded(
    () {
      runApp(const MyApp());
    },
    (error, stackTrace) {
      log.wtf(null, error, stackTrace);
    },
  );
}
