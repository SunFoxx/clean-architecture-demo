import 'package:equatable/equatable.dart';

abstract class MakesErrorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoError extends MakesErrorState {}

class LoadingError extends MakesErrorState {
  final String message;

  LoadingError(this.message);

  @override
  List<Object?> get props => [message];
}
