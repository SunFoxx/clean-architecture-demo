import 'package:equatable/equatable.dart';

class Manufacturer extends Equatable {
  final String name;
  final String country;

  const Manufacturer({
    required this.name,
    required this.country,
  });

  @override
  List<Object?> get props => [
        name,
        country,
      ];
}
