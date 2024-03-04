class UnsupportedStorageTypeException<T> implements Exception {
  const UnsupportedStorageTypeException();

  @override
  String toString() => 'Type $T is unsupported for storage';
}
