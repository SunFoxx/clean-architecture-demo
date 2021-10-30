import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';

abstract class ManufacturersRepository {
  Future<Result<List<Manufacturer>, Exception>> fetchManufacturers(int page);
}
