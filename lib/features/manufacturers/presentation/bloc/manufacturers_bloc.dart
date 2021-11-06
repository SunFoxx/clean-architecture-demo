import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jimmy_test/core/entities/result.dart';
import 'package:jimmy_test/core/errors/usecases/map_error_to_message.dart';
import 'package:jimmy_test/features/manufacturers/domain/entities/manufacturer.dart';
import 'package:jimmy_test/features/manufacturers/domain/usecases/load_manufacturers.dart';

part 'error_state.dart';
part 'manufacturers_event.dart';
part 'manufacturers_state.dart';

class ManufacturersBloc extends Bloc<ManufacturersEvent, ManufacturersState> {
  final LoadManufacturers _loadManufacturers;
  final MapErrorToMessage _mapErrorToMessage;

  int _lastPage = 0;

  ManufacturersBloc({
    required LoadManufacturers loadManufacturers,
    required MapErrorToMessage mapErrorToMessage,
  })  : _loadManufacturers = loadManufacturers,
        _mapErrorToMessage = mapErrorToMessage,
        super(ManufacturersState.initial()) {
    on<InitManufacturersPage>(_onInitManufacturersPage);
    on<LoadNextPageEvent>(_onLoadNextPage);
  }

  void _onInitManufacturersPage(InitManufacturersPage event, Emitter emit) async {
    emit(ManufacturersState.initial());
    _lastPage = 0;
    await _loadNextManufacturersPage(emit);
  }

  void _onLoadNextPage(LoadNextPageEvent event, Emitter emit) async {
    await _loadNextManufacturersPage(emit);
  }

  Future _loadNextManufacturersPage(Emitter emit) async {
    if (state.isLoading || !state.canLoadMore) return;

    emit(state.copyWith(isLoading: true, errorState: NoError()));

    try {
      final loadingResult = await _loadManufacturers(LoadManufacturersParams(_lastPage + 1));

      if (loadingResult.isError()) {
        throw loadingResult as Error;
      }

      _lastPage += 1;
      final manufacturers = loadingResult.successResult();

      return emit(ManufacturersState(
        loadedManufacturers: [...state.loadedManufacturers, ...manufacturers],
        canLoadMore: manufacturers.isNotEmpty,
        isLoading: false,
        errorState: NoError(),
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
