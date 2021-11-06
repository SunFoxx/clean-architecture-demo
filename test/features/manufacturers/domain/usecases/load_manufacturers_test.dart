import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/features/manufacturers/domain/repositories/manufacturers_repository.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/manufacturers/manufacturers_test_models.dart';
import 'load_manufacturers_test.mocks.dart';

@GenerateMocks([ManufacturersRepository])
void main() {
  late MockManufacturersRepository manufacturersRepository;
  late LoadManufacturers useCase;

  const tManufacturersPage1 = ManufacturersTestModels.tManufacturerEntitiesPage1;
  const tManufacturersPage2 = ManufacturersTestModels.tManufacturerEntitiesPage2;
  const tManufacturersEmptyPage = ManufacturersTestModels.tManufacturerEntitiesPage3;
  final tManufacturersPage1Response = Future.value(Success(tManufacturersPage1));
  final tManufacturersPage2Response = Future.value(Success(tManufacturersPage2));
  final tManufacturersOutOfBoundResponse = Future.value(Success(tManufacturersEmptyPage));

  setUp(() {
    manufacturersRepository = MockManufacturersRepository();
    useCase = LoadManufacturers(repository: manufacturersRepository);
  });

  test('should forward result from repository when requested with different pages', () async {
    // arrange
    when(manufacturersRepository.fetchManufacturers(argThat(isA<int>())))
        .thenAnswer((invocation) async {
      final page = invocation.positionalArguments[0] as int;
      switch (page) {
        case 1:
          return tManufacturersPage1Response;
        case 2:
          return tManufacturersPage2Response;
        default:
          return tManufacturersOutOfBoundResponse;
      }
    });

    // act
    final page1Result = await useCase(const LoadManufacturersParams(1));
    final page2Result = await useCase(const LoadManufacturersParams(2));
    final outOfBoundsPageResult = await useCase(const LoadManufacturersParams(3));

    // assert
    expect(page1Result.isSuccess(), isTrue);
    expect(page2Result.isSuccess(), isTrue);
    expect(outOfBoundsPageResult.isSuccess(), isTrue);
    expect(page1Result.successResult(), tManufacturersPage1);
    expect(page2Result.successResult(), tManufacturersPage2);
    expect(outOfBoundsPageResult.successResult(), tManufacturersEmptyPage);
    verifyInOrder([
      manufacturersRepository.fetchManufacturers(1),
      manufacturersRepository.fetchManufacturers(2),
      manufacturersRepository.fetchManufacturers(3),
    ]);
    verifyNoMoreInteractions(manufacturersRepository);
  });
}
