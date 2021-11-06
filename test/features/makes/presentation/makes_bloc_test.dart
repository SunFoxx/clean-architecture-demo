import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/features/makes/domain/usecases/load_makes_by_manufacturer_id.dart';
import 'package:jimmy_test/features/makes/presentation/bloc/error_state.dart';
import 'package:jimmy_test/features/makes/presentation/bloc/makes_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/makes/makes_test_models.dart';
import '../../../fixtures/manufacturers/manufacturers_test_models.dart';
import 'makes_bloc_test.mocks.dart';

@GenerateMocks([LoadMakesByManufacturersId, MapErrorToMessage])
main() {
  late MakesBloc bloc;
  late MockLoadMakesByManufacturersId loadMakesByManufacturersId;
  late MockMapErrorToMessage mapErrorToMessage;

  const tErrorMessage = 'Test error message';
  const tUnexpectedError = UnexpectedError(tErrorMessage);
  const tMakes = MakesTestModels.tMakeEntities987;
  final tManufacturer = ManufacturersTestModels.tManufacturerEntitiesPage1[0];

  setUp(() {
    loadMakesByManufacturersId = MockLoadMakesByManufacturersId();
    mapErrorToMessage = MockMapErrorToMessage();
    bloc = MakesBloc(
      loadMakesByManufacturersId: loadMakesByManufacturersId,
      mapErrorToMessage: mapErrorToMessage,
    );

    when(mapErrorToMessage(any)).thenAnswer((_) async => tErrorMessage);
  });

  tearDown(() {
    bloc.close();
  });

  test('should have proper initial state', () {
    expect(bloc.state, MakesState.initial());
  });

  group('load makes by manufacturer', () {
    final tInitialState = MakesState.initial();

    test('should abort loading upon error and change errorState with mapped message', () async {
      // arrange
      when(loadMakesByManufacturersId(any)).thenAnswer((_) async => Error(tUnexpectedError));

      // act
      bloc.add(LoadMakesFromManufacturer(tManufacturer));

      // assert
      await expectLater(
          bloc.stream,
          emitsInOrder([
            tInitialState.copyWith(isLoading: true),
            tInitialState.copyWith(errorState: LoadingError(tErrorMessage)),
          ]));
      verify(mapErrorToMessage(const ErrorMessageMapperParameters(error: tUnexpectedError)));
    });

    test('should emit state with loaded list when loaded successfully', () async {
      // arrange
      when(loadMakesByManufacturersId(any)).thenAnswer((_) async => Success(tMakes));

      // act
      bloc.add(LoadMakesFromManufacturer(tManufacturer));

      // assert
      expectLater(
          bloc.stream,
          emitsInOrder([
            tInitialState.copyWith(isLoading: true),
            tInitialState.copyWith(makes: tMakes),
          ]));
    });
  });
}
