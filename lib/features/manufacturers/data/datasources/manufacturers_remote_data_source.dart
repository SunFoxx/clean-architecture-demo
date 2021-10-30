import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/vehicles_api_routes.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_response_model.dart';

abstract class ManufacturersRemoteDataSource {
  Future<List<ManufacturerModel>> fetchManufacturersList(int page);
}

/// A very simple HTTP client-based (DIO) access point to receive manufacturers data through the REST Api
class ManufacturersApiRemoteDataSource implements ManufacturersRemoteDataSource {
  final Dio _vehiclesApiClient;

  ManufacturersApiRemoteDataSource({required Dio client}) : _vehiclesApiClient = client;

  @override
  Future<List<ManufacturerModel>> fetchManufacturersList(int page) async {
    final response = await _vehiclesApiClient.get(
      VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
      queryParameters: {
        'format': 'json',
        'page': page,
      },
    );

    if (response.statusCode != 200) {
      throw ServerError();
    }

    final responseModel = ManufacturerResponseModel.fromJson(jsonDecode(response.data));
    return responseModel.results;
  }
}
