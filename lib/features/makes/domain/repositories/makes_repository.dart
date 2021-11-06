import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';

abstract class MakesRepository {
  Future<Result<List<Make>, Exception>> getMakesByManufacturerId(int id);
}
