import 'package:equatable/equatable.dart';

class Make extends Equatable {
  final String name;

  const Make(this.name);

  @override
  List<Object?> get props => [name];
}
