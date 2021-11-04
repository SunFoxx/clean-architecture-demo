part of 'manufacturers_bloc.dart';

/// My personal preference is to have a single state class rather than several subclasses
/// It's not only allows you to keep the overall state while performing single changes
/// but also allows you to avoid issues regarding OOP inheritance
/// To demonstrate how you can possibly manage sub-states within a single state, I've created [ManufacturersErrorState] field,
/// that can take any forms regardless of container state class
class ManufacturersState extends Equatable {
  final List<Manufacturer> loadedManufacturers;
  final bool canLoadMore;
  final bool isLoading;
  final ManufacturersErrorState errorState;

  @override
  List<Object?> get props => [loadedManufacturers, canLoadMore, isLoading, errorState];

  const ManufacturersState({
    required this.loadedManufacturers,
    required this.canLoadMore,
    required this.isLoading,
    required this.errorState,
  });

  factory ManufacturersState.initial() => ManufacturersState(
        loadedManufacturers: const [],
        canLoadMore: true,
        isLoading: false,
        errorState: NoError(),
      );

  ManufacturersState copyWith({
    List<Manufacturer>? loadedManufacturers,
    bool? canLoadMore,
    bool? isLoading,
    ManufacturersErrorState? errorState,
  }) {
    return ManufacturersState(
      loadedManufacturers: loadedManufacturers ?? this.loadedManufacturers,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      isLoading: isLoading ?? this.isLoading,
      errorState: errorState ?? this.errorState,
    );
  }
}
