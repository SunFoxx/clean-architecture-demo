import 'package:equatable/equatable.dart';

class Manufacturer extends Equatable {
  final String name;
  final String country;
  final int id;

  const Manufacturer({
    required this.name,
    required this.country,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        country,
        id,
      ];
}
