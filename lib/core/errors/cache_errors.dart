part of 'errors.dart';

class CacheError implements Exception {}

class CacheStorageUnavailable extends CacheError {
  final String storageName;

  CacheStorageUnavailable(this.storageName);

  @override
  String toString() {
    return 'Storage "$storageName" currently unavailable and can\'t be accessed';
  }
}

class CacheDataCorrupted extends CacheError {
  final String storageName;
  final String corruptedKey;

  CacheDataCorrupted(this.storageName, this.corruptedKey);

  @override
  String toString() {
    return 'The accessed data with key "$corruptedKey" from the local storage "$storageName" might be broken or wrongly formatted';
  }
}

class CacheDataNotFound extends CacheError {
  final String storageName;
  final String missingKey;

  CacheDataNotFound(this.storageName, this.missingKey);

  @override
  String toString() {
    return 'You\'ve tried to access value with key "$missingKey" from storage "$storageName", but it does not exists';
  }
}
