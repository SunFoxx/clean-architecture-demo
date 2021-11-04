import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/entities/usecase.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/domain/repositories/manufacturers_repository.dart';

/// Business case for triggering the manufacturers loading logic
class LoadManufacturers
    implements UseCase<Result<List<Manufacturer>, Exception>, LoadManufacturersParams> {
  final ManufacturersRepository _repository;

  LoadManufacturers({required ManufacturersRepository repository}) : _repository = repository;

  @override
  Future<Result<List<Manufacturer>, Exception>> call(LoadManufacturersParams params) async {
    final manufacturersResult = await _repository.fetchManufacturers(params.page);

    return manufacturersResult;
  }
}

class LoadManufacturersParams {
  final int page;

  LoadManufacturersParams(this.page) : assert(page > 0);
}
