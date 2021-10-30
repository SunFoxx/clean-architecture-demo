import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/errors/cache_errors.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/network/network_info.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_remote_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:jimmy_test/features/manufacturers/data/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'manufacturers_repository_test.mocks.dart';

@GenerateMocks([ManufacturersLocalDataSource, ManufacturersRemoteDataSource, NetworkInfo])
main() {
  late MockManufacturersLocalDataSource localDataSource;
  late MockManufacturersRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late ManufacturersRepositoryImpl manufacturersRepository;

  setUp(() {
    localDataSource = MockManufacturersLocalDataSource();
    remoteDataSource = MockManufacturersRemoteDataSource();
    networkInfo = MockNetworkInfo();
    manufacturersRepository = ManufacturersRepositoryImpl(
      networkInfo: networkInfo,
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );

    // handle calls by default
    when(remoteDataSource.fetchManufacturersList(any)).thenAnswer((_) async => []);
    when(localDataSource.preserveManufacturersList(any, any)).thenAnswer((_) async => true);
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

  group('fetchManufacturers method', () {
    const tPage = 1;
    final tManufacturersModels = [
      const ManufacturerModel(name: 'M1', country: 'NL', id: 1),
      const ManufacturerModel(name: 'M2', country: 'RU', id: 2),
    ];
    final tManufacturers = [
      const Manufacturer(name: 'M1', country: 'NL'),
      const Manufacturer(name: 'M2', country: 'RU'),
    ];

    test('should check if device online', () async {
      // arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.fetchManufacturersList(any)).thenAnswer((_) async => []);
      when(localDataSource.preserveManufacturersList(any, any)).thenAnswer((_) async => true);
      // act
      manufacturersRepository.fetchManufacturers(tPage);
      // assert
      verify(networkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(remoteDataSource.fetchManufacturersList(any))
            .thenAnswer((_) async => tManufacturersModels);

        // act
        final result = await manufacturersRepository.fetchManufacturers(tPage);

        // assert
        verify(remoteDataSource.fetchManufacturersList(tPage));
        expect(result.isSuccess(), isTrue);
        expect(result.successResult(), tManufacturers);
      });

      test('should cache the data locally when successfully fetch data from remote data source',
          () async {
        // arrange
        when(remoteDataSource.fetchManufacturersList(any))
            .thenAnswer((_) async => tManufacturersModels);

        // act
        await manufacturersRepository.fetchManufacturers(tPage);

        // assert
        verify(remoteDataSource.fetchManufacturersList(tPage));
        verify(localDataSource.preserveManufacturersList(tPage, tManufacturersModels));
      });

      test('should return ServerError when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(remoteDataSource.fetchManufacturersList(any))
            .thenAnswer((_) async => throw ServerError());

        // act
        final result = await manufacturersRepository.fetchManufacturers(tPage);

        // assert
        verify(remoteDataSource.fetchManufacturersList(tPage));
        expect(result.isSuccess(), isFalse);
        expect(result.errorResult(), isA<ServerError>());
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cached data is present', () async {
        // arrange
        when(localDataSource.fetchManufacturersList(tPage))
            .thenAnswer((_) async => tManufacturersModels);

        // act
        final result = await manufacturersRepository.fetchManufacturers(tPage);

        // assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.fetchManufacturersList(tPage));
        expect(result.isSuccess(), isTrue);
        expect(result.successResult(), tManufacturers);
      });

      test('should return CacheError when there is no cached data present', () async {
        // arrange
        when(localDataSource.fetchManufacturersList(tPage))
            .thenAnswer((_) async => throw CacheError());

        // act
        final result = await manufacturersRepository.fetchManufacturers(tPage);

        // assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.fetchManufacturersList(tPage));
        expect(result.isSuccess(), isFalse);
        expect(result.errorResult(), isA<CacheError>());
      });
    });
  });
}
