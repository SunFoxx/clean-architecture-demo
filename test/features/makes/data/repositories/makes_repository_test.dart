import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_local_data_source.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_remote_datasource.dart';
import 'package:jimmy_test/features/makes/data/repositories/makes_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/makes/makes_test_models.dart';
import 'makes_repository_test.mocks.dart';

@GenerateMocks([MakesLocalDataSource, MakesRemoteDataSource, NetworkInfo])
main() {
  late MockMakesLocalDataSource localDataSource;
  late MockMakesRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late MakesRepositoryImpl makesRepository;

  setUp(() {
    localDataSource = MockMakesLocalDataSource();
    remoteDataSource = MockMakesRemoteDataSource();
    networkInfo = MockNetworkInfo();
    makesRepository = MakesRepositoryImpl(
      networkInfo: networkInfo,
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );

    // handle calls by default
    when(remoteDataSource.fetchMakesByManufacturerId(any)).thenAnswer((_) async => []);
    when(localDataSource.preserveMakesForManufacturer(any, any)).thenAnswer((_) async => true);
  });

  void runTestsOnline(Function body) {
    group('Connectivity is ON', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('Connectivity is OFF', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getMakesByManufacturerId', () {
    const tManufacturerId = MakesTestModels.tManufacturerId;
    const tMakeModels = MakesTestModels.tMakeModels987;
    const tMakes = MakesTestModels.tMakeEntities987;

    test('should check if device online', () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      // act
      makesRepository.getMakesByManufacturerId(tManufacturerId);

      // assert
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(remoteDataSource.fetchMakesByManufacturerId(any)).thenAnswer((_) async => tMakeModels);

        // act
        final result = await makesRepository.getMakesByManufacturerId(tManufacturerId);

        // assert
        verify(remoteDataSource.fetchMakesByManufacturerId(tManufacturerId));
        expect(result.isSuccess(), isTrue);
        expect(result.successResult(), tMakes);
      });

      test('should cache the data locally when successfully fetch data from remote data source',
          () async {
        // arrange
        when(remoteDataSource.fetchMakesByManufacturerId(any)).thenAnswer((_) async => tMakeModels);

        // act
        await makesRepository.getMakesByManufacturerId(tManufacturerId);

        // assert
        verify(remoteDataSource.fetchMakesByManufacturerId(tManufacturerId));
        verify(localDataSource.preserveMakesForManufacturer(tManufacturerId, tMakeModels));
      });

      test('should return ServerError when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(remoteDataSource.fetchMakesByManufacturerId(any))
            .thenAnswer((_) async => throw ServerError(RequestOptions(path: '')));

        // act
        final result = await makesRepository.getMakesByManufacturerId(tManufacturerId);

        // assert
        verify(remoteDataSource.fetchMakesByManufacturerId(tManufacturerId));
        expect(result.isSuccess(), isFalse);
        expect(result.errorResult(), isA<ServerError>());
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cached data is present', () async {
        // arrange
        when(localDataSource.fetchMakesByManufacturersId(tManufacturerId))
            .thenAnswer((_) async => tMakeModels);

        // act
        final result = await makesRepository.getMakesByManufacturerId(tManufacturerId);

        // assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.fetchMakesByManufacturersId(tManufacturerId));
        expect(result.isSuccess(), isTrue);
        expect(result.successResult(), tMakes);
      });

      test('should return CacheError when there is no cached data present', () async {
        // arrange
        when(localDataSource.fetchMakesByManufacturersId(tManufacturerId))
            .thenAnswer((_) async => throw CacheError());

        // act
        final result = await makesRepository.getMakesByManufacturerId(tManufacturerId);

        // assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.fetchMakesByManufacturersId(tManufacturerId));
        expect(result.isSuccess(), isFalse);
        expect(result.errorResult(), isA<CacheError>());
      });
    });
  });
}
