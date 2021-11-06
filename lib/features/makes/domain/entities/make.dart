import 'package:equatable/equatable.dart';

class Make extends Equatable {
  final String name;
  final int id;

  const Make({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
