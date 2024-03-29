import 'package:hive/hive.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/utils/hive.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';

abstract class ManufacturersLocalDataSource {
  /// Gets a list of manufacturers by given page
  Future<List<ManufacturerModel>> fetchManufacturersList(int page);

  /// Persists a whole page of manufacturers
  Future<bool> preserveManufacturersList(int page, List<ManufacturerModel> data);
}

/// Hive-based implementation of local data source
/// Uses page numbers as keys for keeping the whole listing of manufacturers from that page
/// Argument [box] generally serves the testing purpose, but you must be careful when decide to pass a custom box in there
/// Make sure that injected [box] does not contain any old data or artifacts
class ManufacturersHiveLocalDataSource implements ManufacturersLocalDataSource {
  static const PAGED_MANUFACTURERS_HIVE_BOX_KEY = 'paged_manufacturers';

  late Box _box;

  ManufacturersHiveLocalDataSource({Box? box}) {
    _box = box ?? Hive.box(PAGED_MANUFACTURERS_HIVE_BOX_KEY);
  }

  @override
  Future<List<ManufacturerModel>> fetchManufacturersList(int page) {
    final list = HiveUtils.readListOf<ManufacturerModel>(_box, page);
    return Future.value(list);
  }

  @override
  Future<bool> preserveManufacturersList(int page, List<ManufacturerModel> data) {
    if (!_box.isOpen) {
      throw CacheStorageUnavailable(_box.name);
    }

    _box.put(page, data);
    return Future.value(true);
  }
}
