/// Callable class to define single-responsibility functionality unit
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}
