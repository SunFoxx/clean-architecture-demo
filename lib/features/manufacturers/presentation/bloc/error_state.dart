part of 'manufacturers_bloc.dart';

abstract class ManufacturersErrorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoError extends ManufacturersErrorState {}

class LoadingError extends ManufacturersErrorState {
  final String message;

  LoadingError(this.message);

  @override
  List<Object?> get props => [message];
}
