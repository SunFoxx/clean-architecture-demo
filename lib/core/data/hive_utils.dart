import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';

class HiveUtils {
  static Future initHive() async {
    await Hive.initFlutter();

    /// typeId: 1
    Hive.registerAdapter(ManufacturerModelAdapter());

    await Hive.openBox(ManufacturersHiveLocalDataSource.PAGED_MANUFACTURERS_HIVE_BOX_KEY);
  }
}
