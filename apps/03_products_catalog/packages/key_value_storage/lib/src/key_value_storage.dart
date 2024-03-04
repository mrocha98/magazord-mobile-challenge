import 'dart:async';

abstract interface class KeyValueStorage {
  FutureOr<T?> get<T>(String key);

  FutureOr<void> set<T>(String key, T value);

  FutureOr<bool> has(String key);

  FutureOr<void> delete(String key);

  FutureOr<void> clear();
}
