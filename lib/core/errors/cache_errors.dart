part of 'errors.dart';

class CacheError implements Exception {}

class CacheStorageUnavailable extends CacheError {
  final String storageName;

  CacheStorageUnavailable(this.storageName);

  @override
  String toString() {
    return 'Cache storage can\'t be accessed. It might not have been initialized properly';
  }
}

class CacheDataCorrupted extends CacheError {
  final String storageName;
  final String corruptedKey;

  CacheDataCorrupted(this.storageName, this.corruptedKey);

  @override
  String toString() {
    return 'The accessed data from the local storage might be broken or wrongly formatted';
  }
}

class CacheDataNotFound extends CacheError {
  final String storageName;
  final String missingKey;

  CacheDataNotFound(this.storageName, this.missingKey);

  @override
  String toString() {
    return 'You\'ve tried to access storage value that does not exists';
  }
}
