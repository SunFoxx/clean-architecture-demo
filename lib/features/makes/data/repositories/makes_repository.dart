import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_local_data_source.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_remote_datasource.dart';
import 'package:jimmy_test/features/makes/data/models/make_model.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';
import 'package:jimmy_test/features/makes/domain/repositories/makes_repository.dart';

/// Here we manage our makes data sources whose serve the same purpose - provide us with data
/// Its strategy is quite straight-forward - we use local source only when there is no possibility to reach network
/// It also maps [MakeModel] from responses into domain level entity [Make]
class MakesRepositoryImpl implements MakesRepository {
  final NetworkInfo _networkInfo;
  final MakesLocalDataSource _localDataSource;
  final MakesRemoteDataSource _remoteDataSource;

  MakesRepositoryImpl({
    required NetworkInfo networkInfo,
    required MakesLocalDataSource localDataSource,
    required MakesRemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<Make>, Exception>> getMakesByManufacturerId(int id) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      List<MakeModel> models;

      if (isConnected) {
        try {
          models = await _remoteDataSource.fetchMakesByManufacturerId(id);
          await _localDataSource.preserveMakesForManufacturer(id, models);
        } on ServerError catch (serverError) {
          return Error(serverError);
        } on BadConnectionError catch (connectivityError) {
          return Error(connectivityError);
        }
      } else {
        try {
          models = await _localDataSource.fetchMakesByManufacturersId(id);
        } on CacheError catch (cacheError) {
          return Error(cacheError);
        }
      }

      final makes = _mapMakeModels(models);
      return Success(makes);
    } catch (unexpectedError) {
      return Error(UnexpectedError(unexpectedError.toString()));
    }
  }

  List<Make> _mapMakeModels(List<MakeModel> models) {
    return models.map((model) => Make(name: model.name, id: model.id)).toList();
  }
}
