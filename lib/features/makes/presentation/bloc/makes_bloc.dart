import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/features/makes/domain/entities/make.dart';
import 'package:jimmy_test/features/makes/domain/usecases/load_makes_by_manufacturer_id.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';

import 'error_state.dart';

part 'makes_event.dart';
part 'makes_state.dart';

class MakesBloc extends Bloc<MakesEvent, MakesState> {
  final LoadMakesByManufacturersId _loadMakes;
  final MapErrorToMessage _mapErrorToMessage;

  MakesBloc({
    required LoadMakesByManufacturersId loadMakesByManufacturersId,
    required MapErrorToMessage mapErrorToMessage,
  })  : _loadMakes = loadMakesByManufacturersId,
        _mapErrorToMessage = mapErrorToMessage,
        super(MakesState.initial()) {
    on<LoadMakesFromManufacturer>(_onLoadMakesFromManufacturer);
  }

  void _onLoadMakesFromManufacturer(LoadMakesFromManufacturer event, Emitter emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorState: NoError()));

    try {
      final loadingResult =
          await _loadMakes(LoadMakesByManufacturerIdParams(event.manufacturer.id));
      if (loadingResult.isError()) {
        throw loadingResult as Error;
      }

      final makes = loadingResult.successResult();
      return emit(state.copyWith(
        isLoading: false,
        errorState: NoError(),
        makes: makes,
      ));
    } on Error catch (error) {
      final message = await _mapErrorToMessage(ErrorMessageMapperParameters(error: error.error));
      return emit(state.copyWith(
        isLoading: false,
        errorState: LoadingError(message),
      ));
    }
  }
}
