import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_local_data_source.dart';
import 'package:jimmy_test/features/makes/data/models/make_model.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';

class HiveUtils {
  /// Inits the Hive, register all of its type adapters
  /// and opens all the boxes so that they can be accessed synchronously without any issues
  static Future initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ManufacturerModelAdapter()); // typeId: 1
    Hive.registerAdapter(MakeModelAdapter()); // typeId: 2

    await Hive.openBox(ManufacturersHiveLocalDataSource.PAGED_MANUFACTURERS_HIVE_BOX_KEY);
    await Hive.openBox(MakesHiveLocalDataSource.MAKES_BY_MANUFACTURER_ID_HIVE_BOX_KEY);
  }

  /// Gets the list of type [T] out of the passed box
  /// Handles all ongoing cache errors
  static List<T> readListOf<T>(Box box, dynamic key) {
    if (!box.isOpen) {
      throw CacheStorageUnavailable(box.name);
    }

    if (box.isEmpty || !box.containsKey(key)) {
      throw CacheDataNotFound(box.name, key.toString());
    }

    final boxValue = box.get(key);
    if (boxValue is! List) {
      throw CacheDataCorrupted(box.name, key.toString());
    }

    try {
      return boxValue.cast<T>();
    } catch (_) {
      throw CacheDataCorrupted(box.name, key.toString());
    }
  }
}
