part of 'makes_bloc.dart';

abstract class MakesEvent extends Equatable {}

class LoadMakesFromManufacturer extends MakesEvent {
  final Manufacturer manufacturer;

  LoadMakesFromManufacturer(this.manufacturer);

  @override
  List<Object?> get props => [manufacturer];
}
