import 'dart:async';
import 'dart:convert';

import 'package:magazord_key_value_storage/src/exceptions/exceptions.dart';
import 'package:magazord_key_value_storage/src/key_value_storage.dart';
import 'package:mmkv/mmkv.dart';

class KeyValueStorageMMKVImpl implements KeyValueStorage {
  KeyValueStorageMMKVImpl(this._mmkv);

  final MMKV _mmkv;

  /// [T] supported types:
  ///
  /// - [int]
  /// - [double]
  /// - [String]
  /// - [bool]
  /// - [List]<[String]>
  ///
  /// Throws [UnsupportedStorageTypeException] if [T] is unsupported.
  @override
  FutureOr<T?> get<T>(String key) {
    switch (T) {
      case int:
        return _mmkv.decodeInt32(key) as T?;
      case double:
        return _mmkv.decodeDouble(key) as T?;
      case String:
        return _mmkv.decodeString(key) as T?;
      case bool:
        return _mmkv.decodeBool(key) as T;
      case const (List<String>):
        final storedString = _mmkv.decodeString(key);
        if (storedString == null) return null;
        return List<String>.from(
          json.decode(storedString) as Iterable,
          growable: false,
        ) as T;
      default:
        throw UnsupportedStorageTypeException<T>();
    }
  }

  /// [T] supported types:
  ///
  /// - [int]
  /// - [double]
  /// - [String]
  /// - [bool]
  /// - [List]<[String]>
  ///
  /// Throws [UnsupportedStorageTypeException] if [T] is unsupported.
  @override
  FutureOr<void> set<T>(String key, T value) {
    switch (T) {
      case int:
        _mmkv.encodeInt32(key, value as int);
      case double:
        _mmkv.encodeDouble(key, value as double);
      case String:
        _mmkv.encodeString(key, value as String);
      case bool:
        _mmkv.encodeBool(key, value as bool);
      case const (List<String>):
        _mmkv.encodeString(key, json.encode(value));
      default:
        throw UnsupportedStorageTypeException<T>();
    }
  }

  @override
  FutureOr<bool> has(String key) {
    return _mmkv.allKeys.contains(key);
  }

  @override
  FutureOr<void> delete(String key) {
    _mmkv.removeValue(key);
  }

  @override
  FutureOr<void> clear() {
    _mmkv.clearAll();
  }
}
