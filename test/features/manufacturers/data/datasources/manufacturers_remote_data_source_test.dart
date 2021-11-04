import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/vehicles_api_routes.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'manufacturers_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late ManufacturersApiRemoteDataSource remoteDataSource;
  late MockDio client;

  setUp(() {
    client = MockDio();
    remoteDataSource = ManufacturersApiRemoteDataSource(client: client);
  });

  group('fetchManufacturersList', () {
    const tPage = 1;
    final tManufacturerModels = [
      const ManufacturerModel(
        id: 955,
        name: 'TESLA, INC.',
        country: 'UNITED STATES (USA)',
      ),
      const ManufacturerModel(
        id: 956,
        name: 'ASTON MARTIN LAGONDA LIMITED',
        country: 'UNITED KINGDOM (UK)',
      ),
      const ManufacturerModel(
        id: 957,
        name: 'BMW OF NORTH AMERICA, LLC',
        country: 'UNITED STATES (USA)',
      ),
      const ManufacturerModel(
        id: 958,
        name: 'JAGUAR LAND ROVER NA, LLC',
        country: 'UNITED STATES (USA)',
      ),
    ];

    test('should return list of manufacturers if client received 200 status code', () async {
      // arrange
      when(client.get(
        VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: jsonDecode(readFixture(Fixture.manufacturersPage1)),
          ));

      // act
      final result = await remoteDataSource.fetchManufacturersList(tPage);

      // assert
      verify(client.get(VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
          queryParameters: argThat(
            containsPair('page', tPage),
            named: 'queryParameters',
          )));
      expect(result, tManufacturerModels);
    });

    test('should throw an exception if the status code is not 200', () async {
      //arrange
      when(client.get(
        VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
          ));

      //act
      final call = remoteDataSource.fetchManufacturersList;

      //assert
      expect(() => call(tPage), throwsA(isA<ServerError>()));
      verify(client.get(VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
          queryParameters: argThat(
            containsPair('page', tPage),
            named: 'queryParameters',
          )));
    });
  });
}
