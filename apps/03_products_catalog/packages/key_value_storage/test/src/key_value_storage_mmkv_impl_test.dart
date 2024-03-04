import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:magazord_key_value_storage/src/exceptions/exceptions.dart';
import 'package:magazord_key_value_storage/src/key_value_storage_mmkv_impl.dart';

import '../__mocks__/__mocks__.dart';

void main() {
  group('KeyValueStorageMMKVImpl', () {
    late KeyValueStorageMMKVImpl sut;
    late MockMMKV mmkv;

    setUp(() {
      mmkv = MockMMKV();
      sut = KeyValueStorageMMKVImpl(mmkv);
    });

    group('.get', () {
      test(
        'should throw UnsupportedStorageTypeException<T> when T is unsupported',
        () {
          expect(
            () => sut.get<Object>('key'),
            throwsA(isA<UnsupportedStorageTypeException<Object>>()),
          );
          verifyZeroInteractions(mmkv);
        },
      );

      test('should get a String', () {
        when(() => mmkv.decodeString('key')).thenReturn('Hello!');
        final result = sut.get<String>('key');
        expect(result, 'Hello!');
      });

      test('should get a bool', () {
        when(() => mmkv.decodeBool('key')).thenReturn(true);
        final result = sut.get<bool>('key');
        expect(result, isTrue);
      });

      test('should get a double', () {
        when(() => mmkv.decodeDouble('key')).thenReturn(pi);
        final result = sut.get<double>('key');
        expect(result, pi);
      });

      test('should get a int', () {
        when(() => mmkv.decodeInt32('key')).thenReturn(123);
        final result = sut.get<int>('key');
        expect(result, 123);
      });

      group('List<String>', () {
        test(
          'when there is no string with giving key should return null',
          () {
            when(() => mmkv.decodeString('key')).thenReturn(null);
            final result = sut.get<String>('key');
            expect(result, isNull);
          },
        );

        test(
          'when there is a string with giving key '
          'should return it splitting by listSeparator',
          () {
            const list = ['{"a":1,"b":"xyz"}', '{"a":0,"b":"zyx"}'];
            final stored = list.join(KeyValueStorageMMKVImpl.listSeparator);
            when(() => mmkv.decodeString('key')).thenReturn(stored);

            final result = sut.get<List<String>>('key');

            expect(result, list);
          },
        );
      });
    });

    group('.set', () {
      setUp(() {
        when(() => mmkv.encodeInt32(any(), any())).thenAnswer((_) => true);
        when(() => mmkv.encodeDouble(any(), any())).thenAnswer((_) => true);
        when(() => mmkv.encodeString(any(), any())).thenAnswer((_) => true);
        when(() => mmkv.encodeBool(any(), any())).thenAnswer((_) => true);
      });

      test('should set an int', () {
        sut.set<int>('key', 2048);
        verify(() => mmkv.encodeInt32('key', 2048)).called(1);
      });

      test('should set a double', () {
        sut.set<double>('key', pi);
        verify(() => mmkv.encodeDouble('key', pi)).called(1);
      });

      test('should set a String', () {
        sut.set<String>('key', 'Hello!');
        verify(() => mmkv.encodeString('key', 'Hello!')).called(1);
      });

      test('should set a bool', () {
        sut.set<bool>('key', true);
        verify(() => mmkv.encodeBool('key', true)).called(1);
      });

      test('should set a List of string joining by listSeparator', () {
        const list = ['{"a": 1, "b": "xyz"}', '{"a": 0, "b": "zyx"}'];
        final listString = list.join(KeyValueStorageMMKVImpl.listSeparator);

        sut.set<List<String>>('key', list);

        verify(() => mmkv.encodeString('key', listString)).called(1);
      });

      test(
        'should throw UnsupportedStorageTypeException<T> when T is unsupported',
        () {
          expect(
            () => sut.set<Object>('key', Object()),
            throwsA(isA<UnsupportedStorageTypeException<Object>>()),
          );
          verifyZeroInteractions(mmkv);
        },
      );
    });

    group('.has', () {
      const keys = ['a', 'b', 'c'];

      setUp(() {
        when(() => mmkv.allKeys).thenReturn(keys);
      });

      test('when mmkv keys contains the given key should return true', () {
        final result = sut.has('c');

        expect(result, isTrue);
      });

      test(
        'when mmkv keys does not contains the given key should return false',
        () {
          final result = sut.has('d');

          expect(result, isFalse);
        },
      );
    });

    group('delete', () {
      test('should call mmkv removeValue with key', () {
        const key = 'key';
        when(() => mmkv.removeValue(key)).thenAnswer((_) {});

        sut.delete(key);

        verify(() => mmkv.removeValue(key)).called(1);
      });
    });

    group('clear', () {
      test('should call mmkv clearAll', () {
        when(() => mmkv.clearAll()).thenAnswer((_) {});

        sut.clear();

        verify(() => mmkv.clearAll()).called(1);
      });
    });
  });
}
