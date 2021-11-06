import 'package:dio/dio.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/vehicles_api_routes.dart';
import 'package:jimmy_test/features/makes/data/models/make_model.dart';
import 'package:jimmy_test/features/makes/data/models/makes_response_model.dart';

abstract class MakesRemoteDataSource {
  Future<List<MakeModel>> fetchMakesByManufacturerId(int id);
}

class MakesApiRemoteDataSource implements MakesRemoteDataSource {
  final Dio _vehiclesApiClient;

  MakesApiRemoteDataSource({required Dio client}) : _vehiclesApiClient = client;

  @override
  Future<List<MakeModel>> fetchMakesByManufacturerId(int id) async {
    final response = await _vehiclesApiClient.get(
      VehiclesApiRoutes.GET_MAKES_FOR_MANUFACTURER + '/$id',
      queryParameters: {'format': 'json'},
    );

    if (response.statusCode != 200) {
      throw ServerError(response.requestOptions);
    }

    final responseModel = MakesResponseModel.fromJson(response.data);
    return responseModel.results;
  }
}
