import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/vehicles_api_routes.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/manufacturers/manufacturers_test_models.dart';
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
    const tManufacturerModels = ManufacturersTestModels.tManufacturerModelsPage1;

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
      verify(client.get(
        VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
        queryParameters: argThat(
          containsPair('page', tPage),
          named: 'queryParameters',
        ),
      ));
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
      verify(client.get(
        VehiclesApiRoutes.GET_ALL_MANUFACTURERS,
        queryParameters: argThat(
          containsPair('page', tPage),
          named: 'queryParameters',
        ),
      ));
    });
  });
}
