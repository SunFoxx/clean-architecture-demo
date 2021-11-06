import 'package:flutter/material.dart';
import 'package:jimmy_test/app.dart';

import 'core/locator.dart';
import 'core/utils/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await HiveUtils.initHive();
  runApp(const MyApp());
}
