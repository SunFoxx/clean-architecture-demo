import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/domain/repositories/manufacturers_repository.dart';

/// Here we manage our manufacturers data sources whose serve the same purpose - provide us with data
/// Its strategy is quite straight-forward - we use local source only when there is no possibility to reach network
/// It also maps [ManufacturerModel] from responses into domain level entity [Manufacturer]
class ManufacturersRepositoryImpl implements ManufacturersRepository {
  final NetworkInfo _networkInfo;
  final ManufacturersLocalDataSource _localDataSource;
  final ManufacturersRemoteDataSource _remoteDataSource;

  ManufacturersRepositoryImpl({
    required NetworkInfo networkInfo,
    required ManufacturersLocalDataSource localDataSource,
    required ManufacturersRemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Manufacturer>, Exception>> fetchManufacturers(int page) async {
    final isConnected = await _networkInfo.isConnected;
    List<ManufacturerModel> models;

    if (isConnected) {
      try {
        models = await _remoteDataSource.fetchManufacturersList(page);
        await _localDataSource.preserveManufacturersList(page, models);
      } on ServerError catch (e) {
        return Error(e);
      } on BadConnectionError catch (e) {
        return Error(e);
      }
    } else {
      try {
        models = await _localDataSource.fetchManufacturersList(page);
      } on CacheError catch (e) {
        return Error(e);
      }
    }

    final manufacturers = _mapManufacturersModel(models);
    return Success(manufacturers);
  }

  List<Manufacturer> _mapManufacturersModel(List<ManufacturerModel> models) {
    return models
        .map((model) => Manufacturer(
              name: model.name,
              country: model.country,
            ))
        .toList();
  }
}
