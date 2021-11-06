part of 'makes_bloc.dart';

/// My personal preference is to have a single state class rather than several subclasses
/// It's not only allows you to keep the overall state while performing single changes
/// but also allows you to avoid issues regarding OOP inheritance
/// To demonstrate how you can possibly manage sub-states within a single state, I've created [MakesErrorState] field,
/// that can take any forms regardless of container state class
class MakesState extends Equatable {
  final List<Make> makes;
  final bool isLoading;
  final MakesErrorState errorState;

  const MakesState({
    required this.makes,
    required this.isLoading,
    required this.errorState,
  });

  @override
  List<Object?> get props => [makes, isLoading, errorState];

  factory MakesState.initial() => MakesState(
        makes: const [],
        isLoading: false,
        errorState: NoError(),
      );

  MakesState copyWith({
    List<Make>? makes,
    bool? isLoading,
    MakesErrorState? errorState,
  }) {
    return MakesState(
      makes: makes ?? this.makes,
      isLoading: isLoading ?? this.isLoading,
      errorState: errorState ?? this.errorState,
    );
  }
}
