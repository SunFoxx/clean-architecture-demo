import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/features/makes/domain/repositories/makes_repository.dart';
import 'package:jimmy_test/features/makes/domain/usecases/load_makes_by_manufacturer_id.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/makes/makes_test_models.dart';
import 'load_makes_by_manufacturer_id_test.mocks.dart';

@GenerateMocks([MakesRepository])
main() {
  late MockMakesRepository makesRepository;
  late LoadMakesByManufacturersId useCase;

  setUp(() {
    makesRepository = MockMakesRepository();
    useCase = LoadMakesByManufacturersId(makesRepository: makesRepository);
  });

  const tManufacturerId = MakesTestModels.tManufacturerId;
  const tMakes = MakesTestModels.tMakeEntities987;
  final tMakesResponse = Future.value(Success(tMakes));

  test('should forward result from repository when requested with manufacturer id', () async {
    // arrange
    when(makesRepository.getMakesByManufacturerId(tManufacturerId))
        .thenAnswer((_) => tMakesResponse);

    // act
    final result = await useCase(const LoadMakesByManufacturerIdParams(tManufacturerId));

    // assert
    expect(result.isSuccess(), isTrue);
    expect(result.successResult(), tMakes);
    verify(makesRepository.getMakesByManufacturerId(tManufacturerId));
    verifyNoMoreInteractions(makesRepository);
  });
}
