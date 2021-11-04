import 'package:flutter_test/flutter_test.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/errors.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';
import 'package:jimmy_test/features/manufacturers/presentation/bloc/manufacturers_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'manufacturers_bloc_test.mocks.dart';

@GenerateMocks([LoadManufacturers])
main() {
  late ManufacturersBloc bloc;
  late MockLoadManufacturers mockLoadManufacturers;

  setUp(() {
    mockLoadManufacturers = MockLoadManufacturers();
    bloc = ManufacturersBloc(loadManufacturers: mockLoadManufacturers);
  });

  tearDown(() {
    bloc.close();
  });

  const tErrorMessage = 'Test error message';
  const tUnexpectedError = UnexpectedError(tErrorMessage);
  const tManufacturersPage1 = <Manufacturer>[
    Manufacturer(name: 'name1', country: 'country1'),
    Manufacturer(name: 'name2', country: 'country2'),
  ];
  const tManufacturersPage2 = <Manufacturer>[
    Manufacturer(name: 'name3', country: 'country3'),
    Manufacturer(name: 'name4', country: 'country4'),
  ];

  test('should have proper initial state', () {
    expect(bloc.state, ManufacturersState.initial());
  });

  group('load first page', () {
    final tInitialState = ManufacturersState.initial();

    test('should abort loading upon error and change error state', () async {
      // arrange
      when(mockLoadManufacturers(any))
          .thenAnswer((realInvocation) async => Error(tUnexpectedError));

      // act
      bloc.add(InitManufacturersPage());

      // assert
      expectLater(
          bloc.stream,
          emitsInOrder([
            tInitialState,
            tInitialState.copyWith(isLoading: true),
            tInitialState.copyWith(errorState: LoadingError(tUnexpectedError.toString())),
          ]));
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
      expectLater(
          bloc.stream,
          emitsInOrder([
            tLoadedPage1State.copyWith(isLoading: true),
            tLoadedPage1State.copyWith(errorState: LoadingError(tUnexpectedError.toString()))
          ]));
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
