import 'package:hive/hive.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/utils/hive.dart';
import 'package:jimmy_test/features/makes/data/models/make_model.dart';

abstract class MakesLocalDataSource {
  /// Gets a list of makes by given manufacturer id
  Future<List<MakeModel>> fetchMakesByManufacturersId(int id);

  /// Persists a list of makes for a single manufacturer
  Future<bool> preserveMakesForManufacturer(int manufacturerId, List<MakeModel> makes);
}

/// Hive-based implementation of local data source
/// Uses manufacturer id to store its makes as a list
/// Argument [box] generally serves the testing purpose, but you must be careful when decide to pass a custom box in there
/// Make sure that injected [box] does not contain any old data or artifacts
class MakesHiveLocalDataSource implements MakesLocalDataSource {
  static const MAKES_BY_MANUFACTURER_ID_HIVE_BOX_KEY = 'makes_by_manufacturer_id';

  late Box _box;

  MakesHiveLocalDataSource({Box? box}) {
    _box = box ?? Hive.box(MAKES_BY_MANUFACTURER_ID_HIVE_BOX_KEY);
  }

  @override
  Future<List<MakeModel>> fetchMakesByManufacturersId(int id) {
    final list = HiveUtils.readListOf<MakeModel>(_box, id);
    return Future.value(list);
  }

  @override
  Future<bool> preserveMakesForManufacturer(int manufacturerId, List<MakeModel> makes) {
    if (!_box.isOpen) {
      throw CacheStorageUnavailable(_box.name);
    }

    _box.put(manufacturerId, makes);
    return Future.value(true);
  }
}
