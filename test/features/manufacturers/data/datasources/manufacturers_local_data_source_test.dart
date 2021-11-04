import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/features/manufacturers/data/datasources/manufacturers_local_data_source.dart';
import 'package:jimmy_test/features/manufacturers/data/models/manufacturer_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'manufacturers_local_data_source_test.mocks.dart';

@GenerateMocks([Box])
main() {
  late ManufacturersHiveLocalDataSource localDataSource;
  late MockBox box;

  setUp(() {
    box = MockBox();
    localDataSource = ManufacturersHiveLocalDataSource(box: box);

    when(box.isOpen).thenReturn(true);
    when(box.isNotEmpty).thenReturn(true);
    when(box.name).thenReturn(ManufacturersHiveLocalDataSource.PAGED_MANUFACTURERS_HIVE_BOX_KEY);
  });

  const tPage = 1;
  final tManufacturersModels = [
    const ManufacturerModel(id: 111, name: 'name1', country: 'country1'),
    const ManufacturerModel(id: 112, name: 'name2', country: 'country2'),
  ];

  group('fetchManufacturersList', () {
    test('should return the list of manufacturers from page that has been preserved before',
        () async {
      // arrange
      when(box.get(tPage)).thenReturn(tManufacturersModels);
      when(box.containsKey(tPage)).thenReturn(true);

      // act
      final result = await localDataSource.fetchManufacturersList(tPage);

      // assert
      verify(box.isOpen);
      verify(box.containsKey(tPage));
      verify(box.get(tPage));
      expect(result, tManufacturersModels);
    });

    test(
        'should throw CacheDataNotFound if storage does not contain the list of manufacturers for given page',
        () async {
      // arrange
      when(box.containsKey(tPage)).thenReturn(false);

      // act
      final call = localDataSource.fetchManufacturersList;

      // assert
      expect(() => call.call(tPage), throwsA(isA<CacheDataNotFound>()));
      verify(box.isOpen);
      verify(box.containsKey(tPage));
    });

    test('should prevent execution with CacheStorageUnavailable when box isn\'t opened', () async {
      // arrange
      when(box.isOpen).thenReturn(false);

      // act
      final call = localDataSource.fetchManufacturersList;

      // assert
      expect(() => call.call(tPage), throwsA(isA<CacheStorageUnavailable>()));
      verify(box.isOpen);
    });
  });

  group('preserveManufacturersList', () {
    test('should properly save list of manufacturers by given page', () async {
      // arrange
      when(box.put(tPage, tManufacturersModels)).thenAnswer((_) async {});

      // act
      final result = await localDataSource.preserveManufacturersList(tPage, tManufacturersModels);

      // assert
      verify(box.isOpen);
      verify(box.put(tPage, tManufacturersModels));
      expect(result, true);
    });

    test('should prevent execution with CacheStorageUnavailable when box isn\'t opened', () async {
      // arrange
      when(box.isOpen).thenReturn(false);

      // act
      final call = localDataSource.preserveManufacturersList;

      // assert
      expect(() => call.call(tPage, tManufacturersModels), throwsA(isA<CacheStorageUnavailable>()));
      verify(box.isOpen);
    });
  });
}
