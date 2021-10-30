import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jimmy_test/core/network/network_client.dart';

/// Dependency injection container reference
final locator = GetIt.instance;

Future init() async {
  await Hive.initFlutter();
  locator.registerLazySingleton<VehiclesApiClient>(
      () => VehiclesApiClient()..configureVehiclesApiClient());
}
