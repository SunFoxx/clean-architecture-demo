/// Analogue of `Either` class from dartz package
/// BUT with better naming and left-handed success result placement
class Result<A, B extends Exception> {
  bool isSuccess() {
    return this is Success<A, B>;
  }

  A successResult() {
    return (this as Success<A, B>).value;
  }

  bool isError() {
    return this is Error<A, B>;
  }

  B errorResult() {
    return (this as Error<A, B>).error;
  }
}

class Success<A, B extends Exception> extends Result<A, B> {
  final A _value;

  A get value => _value;

  Success(this._value);
}

class Error<A, B extends Exception> extends Result<A, B> {
  final B _error;

  B get error => _error;

  Error(this._error);
}
