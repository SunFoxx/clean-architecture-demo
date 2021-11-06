import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/vehicles_api_routes.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_remote_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/makes/makes_test_models.dart';
import 'makes_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late MakesApiRemoteDataSource remoteDataSource;
  late MockDio client;

  setUp(() {
    client = MockDio();
    remoteDataSource = MakesApiRemoteDataSource(client: client);
  });

  group('fetchMakesByManufacturerId', () {
    const tManufacturerId = MakesTestModels.tManufacturerId;
    const tMakeModels = MakesTestModels.tMakeModels987;
    final apiPath = VehiclesApiRoutes.GET_MAKES_FOR_MANUFACTURER + '/$tManufacturerId';

    test('should return list of makes if client received 200 status code', () async {
      // arrange
      when(client.get(
        apiPath,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: jsonDecode(readFixture(Fixture.makes_for_id987)),
          ));

      // act
      final result = await remoteDataSource.fetchMakesByManufacturerId(tManufacturerId);

      // assert
      verify(client.get(
        apiPath,
        queryParameters: anyNamed('queryParameters'),
      ));
      expect(result, tMakeModels);
    });

    test('should throw an exception if the status code is not 200', () async {
      //arrange
      when(client.get(
        apiPath,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 400,
          ));

      //act
      final call = remoteDataSource.fetchMakesByManufacturerId;

      //assert
      expect(() => call(tManufacturerId), throwsA(isA<ServerError>()));
      verify(client.get(
        apiPath,
        queryParameters: anyNamed('queryParameters'),
      ));
    });
  });
}
