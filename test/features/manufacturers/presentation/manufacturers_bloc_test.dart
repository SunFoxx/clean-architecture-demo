import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';
import 'package:jimmy_test/features/manufacturers/presentation/bloc/manufacturers_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/manufacturers/manufacturers_test_models.dart';
import 'manufacturers_bloc_test.mocks.dart';

@GenerateMocks([LoadManufacturers, MapErrorToMessage])
main() {
  late ManufacturersBloc bloc;
  late MockLoadManufacturers mockLoadManufacturers;
  late MockMapErrorToMessage mapErrorToMessage;

  const tErrorMessage = 'Test error message';
  const tUnexpectedError = UnexpectedError(tErrorMessage);
  const tManufacturersPage1 = ManufacturersTestModels.tManufacturerEntitiesPage1;
  const tManufacturersPage2 = ManufacturersTestModels.tManufacturerEntitiesPage2;

  setUp(() {
    mockLoadManufacturers = MockLoadManufacturers();
    mapErrorToMessage = MockMapErrorToMessage();
    bloc = ManufacturersBloc(
      loadManufacturers: mockLoadManufacturers,
      mapErrorToMessage: mapErrorToMessage,
    );

    when(mapErrorToMessage(any)).thenAnswer((_) async => tErrorMessage);
  });

  tearDown(() {
    bloc.close();
  });

  test('should have proper initial state', () {
    expect(bloc.state, ManufacturersState.initial());
  });

  group('load first page', () {
    final tInitialState = ManufacturersState.initial();

    test('should abort loading upon error and change errorState with mapped message', () async {
      // arrange
      when(mockLoadManufacturers(any))
          .thenAnswer((realInvocation) async => Error(tUnexpectedError));

      // act
      bloc.add(InitManufacturersPage());

      // assert
      await expectLater(
          bloc.stream,
          emitsInOrder([
            tInitialState,
            tInitialState.copyWith(isLoading: true),
            tInitialState.copyWith(errorState: LoadingError(tErrorMessage)),
          ]));
      verify(mapErrorToMessage(const ErrorMessageMapperParameters(error: tUnexpectedError)));
    });

    test('should emit state with loaded list when loaded', () async {
      // arrange
      when(mockLoadManufacturers(any)).thenAnswer((_) async => Success(tManufacturersPage1));

      // act
      bloc.add(InitManufacturersPage());

      // assert
      expectLater(
          bloc.stream,
          emitsInOrder([
            tInitialState,
            tInitialState.copyWith(isLoading: true),
            tInitialState.copyWith(loadedManufacturers: tManufacturersPage1),
          ]));
    });
  });

  group('load next steps', () {
    final tLoadedPage1State = ManufacturersState(
        loadedManufacturers: tManufacturersPage1,
        canLoadMore: true,
        isLoading: false,
        errorState: NoError());

    test(
        'should keep already loaded list when encounter an error during the loading of non-first page',
        () async {
      // arrange
      when(mockLoadManufacturers(any)).thenAnswer((_) async => Error(tUnexpectedError));
      bloc.emit(tLoadedPage1State);

      // act
      bloc.add(LoadNextPageEvent());

      // assert
      await expectLater(
          bloc.stream,
          emitsInOrder([
            tLoadedPage1State.copyWith(isLoading: true),
            tLoadedPage1State.copyWith(errorState: LoadingError(tErrorMessage))
          ]));
      verify(mapErrorToMessage(const ErrorMessageMapperParameters(error: tUnexpectedError)));
    });

    test('should append loaded page to the existing one when loading is completed successfully',
        () async {
      // arrange
      when(mockLoadManufacturers(any)).thenAnswer((_) async => Success(tManufacturersPage2));
      bloc.emit(tLoadedPage1State);

      // act
      bloc.add(LoadNextPageEvent());

      // assert
      expectLater(
          bloc.stream,
          emitsInOrder([
            tLoadedPage1State.copyWith(isLoading: true),
            tLoadedPage1State
                .copyWith(loadedManufacturers: [...tManufacturersPage1, ...tManufacturersPage2]),
          ]));
    });

    test(
        'should stop further loading requests when requested page is successfully returned as empty list',
        () async {
      // arrange
      when(mockLoadManufacturers(any)).thenAnswer((_) async => Success(<Manufacturer>[]));
      bloc.emit(tLoadedPage1State);

      // act
      bloc.add(LoadNextPageEvent());

      // assert
      expectLater(
          bloc.stream,
          emitsInOrder([
            tLoadedPage1State.copyWith(isLoading: true),
            tLoadedPage1State.copyWith(canLoadMore: false),
          ]));
    });
  });
}
