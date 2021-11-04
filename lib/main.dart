import 'package:flutter/material.dart';
import 'package:jimmy_test/app.dart';
import 'package:jimmy_test/core/data/hive_utils.dart';

import 'core/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await HiveUtils.initHive();
  runApp(const MyApp());
}
