import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/features/makes/data/datasources/makes_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/makes/makes_test_models.dart';
import 'makes_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
main() {
  late MakesHiveLocalDataSource localDataSource;
  late MockBox box;

  setUp(() {
    box = MockBox();
    localDataSource = MakesHiveLocalDataSource(box: box);

    when(box.isOpen).thenReturn(true);
    when(box.isEmpty).thenReturn(false);
    when(box.name).thenReturn(MakesHiveLocalDataSource.MAKES_BY_MANUFACTURER_ID_HIVE_BOX_KEY);
  });

  const tManufacturerId = MakesTestModels.tManufacturerId;
  const tMakesModels = MakesTestModels.tMakeModels987;

  group('fetchMakesByManufacturersId', () {
    test('should return list of makes by manufacturer id that has been preserved before', () async {
      // arrange
      when(box.get(tManufacturerId)).thenReturn(tMakesModels);
      when(box.containsKey(tManufacturerId)).thenReturn(true);

      // act
      final result = await localDataSource.fetchMakesByManufacturersId(tManufacturerId);

      // assert
      verify(box.isOpen);
      verify(box.containsKey(tManufacturerId));
      verify(box.get(tManufacturerId));
      expect(result, tMakesModels);
    });

    test(
        'should throw CacheDataNotFound if storage does not contain the list of makes for given manufacturer id',
        () async {
      // arrange
      when(box.containsKey(tManufacturerId)).thenReturn(false);

      // act
      final call = localDataSource.fetchMakesByManufacturersId;

      // assert
      expect(() => call.call(tManufacturerId), throwsA(isA<CacheDataNotFound>()));
      verify(box.isOpen);
      verify(box.containsKey(tManufacturerId));
    });

    test('should prevent execution with CacheStorageUnavailable when box isn\'t opened', () async {
      // arrange
      when(box.isOpen).thenReturn(false);

      // act
      final call = localDataSource.fetchMakesByManufacturersId;

      // assert
      expect(() => call.call(tManufacturerId), throwsA(isA<CacheStorageUnavailable>()));
      verify(box.isOpen);
    });
  });

  group('preserveMakesForManufacturer', () {
    test('should properly save list of makes by given manufacturer id', () async {
      // arrange
      when(box.put(tManufacturerId, tMakesModels)).thenAnswer((_) async {});

      // act
      final result =
          await localDataSource.preserveMakesForManufacturer(tManufacturerId, tMakesModels);

      // assert
      verify(box.isOpen);
      verify(box.put(tManufacturerId, tMakesModels));
      expect(result, true);
    });

    test('should prevent execution with CacheStorageUnavailable when box isn\'t opened', () async {
      // arrange
      when(box.isOpen).thenReturn(false);

      // act
      final call = localDataSource.preserveMakesForManufacturer;

      // assert
      expect(
          () => call.call(tManufacturerId, tMakesModels), throwsA(isA<CacheStorageUnavailable>()));
      verify(box.isOpen);
    });
  });
}
