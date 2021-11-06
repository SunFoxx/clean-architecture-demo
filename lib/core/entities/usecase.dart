import 'package:equatable/equatable.dart';

/// Callable class to define single-responsibility functionality unit
abstract class UseCase<T, Params extends Equatable> {
  Future<T> call(Params params);
}
