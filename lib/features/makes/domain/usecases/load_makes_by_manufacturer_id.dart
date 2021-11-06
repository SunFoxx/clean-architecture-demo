import 'package:equatable/equatable.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/entities/usecase.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';
import 'package:jimmy_test/features/makes/domain/repositories/makes_repository.dart';

class LoadMakesByManufacturersId
    implements UseCase<Result<List<Make>, Exception>, LoadMakesByManufacturerIdParams> {
  final MakesRepository _makesRepository;

  LoadMakesByManufacturersId({required MakesRepository makesRepository})
      : _makesRepository = makesRepository;

  @override
  Future<Result<List<Make>, Exception>> call(LoadMakesByManufacturerIdParams params) async {
    final result = await _makesRepository.getMakesByManufacturerId(params.manufacturerId);
    return result;
  }
}

class LoadMakesByManufacturerIdParams extends Equatable {
  final int manufacturerId;

  const LoadMakesByManufacturerIdParams(this.manufacturerId);

  @override
  List<Object?> get props => [manufacturerId];
}
