import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:magazord_logger/src/log_level.dart';
import 'package:magazord_logger/src/logger_impl.dart';

import '../__mocks__/__mocks__.dart';

void main() {
  group('LoggerImpl', () {
    late LoggerImpl sut;
    late MockLoggerPkg loggerPkg;

    setUpAll(() {
      registerFallbackValue(StackTrace.empty);
    });

    setUp(() {
      loggerPkg = MockLoggerPkg();
      sut = LoggerImpl(loggerPkg);
    });

    group('level', () {
      test('should be LogLevel.debug by default', () {
        expect(sut.level, LogLevel.debug);
      });

      test('should set level', () {
        sut.level = LogLevel.warning;
        expect(sut.level, LogLevel.warning);
      });
    });

    group('.debug', () {
      setUp(() {
        when(() => loggerPkg.d(any<dynamic>())).thenAnswer((_) {});
      });

      test('should not be able to log when level is silent', () {
        sut
          ..level = LogLevel.silent
          ..debug('message');

        verifyNever(() => loggerPkg.d('message'));
      });

      test('should not be able to log when level is fatal', () {
        sut
          ..level = LogLevel.fatal
          ..debug('message');

        verifyNever(() => loggerPkg.d('message'));
      });

      test('should not be able to log when level is error', () {
        sut
          ..level = LogLevel.error
          ..debug('message');

        verifyNever(() => loggerPkg.d('message'));
      });

      test('should not be able to log when level is warning', () {
        sut
          ..level = LogLevel.warning
          ..debug('message');

        verifyNever(() => loggerPkg.d('message'));
      });

      test('should not be able to log when level is info', () {
        sut
          ..level = LogLevel.info
          ..debug('message');

        verifyNever(() => loggerPkg.d('message'));
      });

      test('should be able to log when level is debug', () {
        sut
          ..level = LogLevel.debug
          ..debug('message');

        verify(() => loggerPkg.d('message')).called(1);
      });
    });

    group('.info', () {
      setUp(() {
        when(() => loggerPkg.i(any<dynamic>())).thenAnswer((_) {});
      });

      test('should not be able to log when level is silent', () {
        sut
          ..level = LogLevel.silent
          ..info('message');

        verifyNever(() => loggerPkg.i('message'));
      });

      test('should not be able to log when level is fatal', () {
        sut
          ..level = LogLevel.fatal
          ..info('message');

        verifyNever(() => loggerPkg.i('message'));
      });

      test('should not be able to log when level is error', () {
        sut
          ..level = LogLevel.error
          ..info('message');

        verifyNever(() => loggerPkg.i('message'));
      });

      test('should not be able to log when level is warning', () {
        sut
          ..level = LogLevel.warning
          ..info('message');

        verifyNever(() => loggerPkg.i('message'));
      });

      test('should be able to log when level is info', () {
        sut
          ..level = LogLevel.info
          ..info('message');

        verify(() => loggerPkg.i('message')).called(1);
      });

      test('should be able to log when level is debug', () {
        sut
          ..level = LogLevel.debug
          ..info('message');

        verify(() => loggerPkg.i('message')).called(1);
      });
    });

    group('.warning', () {
      setUp(() {
        when(
          () => loggerPkg.w(
            any<dynamic>(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).thenAnswer((_) {});
      });

      void verifyLogWarningCalledOnce() {
        verify(
          () => loggerPkg.w(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        ).called(1);
      }

      void verifyLogWarningNeverCalled() {
        verifyNever(
          () => loggerPkg.w(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        );
      }

      test('should not be able to log when level is silent', () {
        sut
          ..level = LogLevel.silent
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningNeverCalled();
      });

      test('should not be able to log when level is fatal', () {
        sut
          ..level = LogLevel.fatal
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningNeverCalled();
      });

      test('should not be able to log when level is error', () {
        sut
          ..level = LogLevel.error
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningNeverCalled();
      });

      test('should be able to log when level is warning', () {
        sut
          ..level = LogLevel.warning
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningCalledOnce();
      });

      test('should be able to log when level is info', () {
        sut
          ..level = LogLevel.info
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningCalledOnce();
      });

      test('should be able to log when level is debug', () {
        sut
          ..level = LogLevel.debug
          ..warning('message', 'error', StackTrace.empty);

        verifyLogWarningCalledOnce();
      });
    });

    group('.error', () {
      setUp(() {
        when(
          () => loggerPkg.e(
            any<dynamic>(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).thenAnswer((_) {});
      });

      void verifyLogErrorCalledOnce() {
        verify(
          () => loggerPkg.e(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        ).called(1);
      }

      void verifyLogErrorNeverCalled() {
        verifyNever(
          () => loggerPkg.e(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        );
      }

      test('should not be able to log when level is silent', () {
        sut
          ..level = LogLevel.silent
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorNeverCalled();
      });

      test('should not be able to log when level is fatal', () {
        sut
          ..level = LogLevel.fatal
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorNeverCalled();
      });

      test('should be able to log when level is error', () {
        sut
          ..level = LogLevel.error
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorCalledOnce();
      });

      test('should be able to log when level is warning', () {
        sut
          ..level = LogLevel.warning
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorCalledOnce();
      });

      test('should be able to log when level is info', () {
        sut
          ..level = LogLevel.info
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorCalledOnce();
      });

      test('should be able to log when level is debug', () {
        sut
          ..level = LogLevel.debug
          ..error('message', 'error', StackTrace.empty);

        verifyLogErrorCalledOnce();
      });
    });

    group('.fatal', () {
      setUp(() {
        when(
          () => loggerPkg.f(
            any<dynamic>(),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).thenAnswer((_) {});
      });

      void verifyLogFatalCalledOnce() {
        verify(
          () => loggerPkg.f(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        ).called(1);
      }

      test('should not be able to log when level is silent', () {
        sut
          ..level = LogLevel.silent
          ..fatal('message', 'error', StackTrace.empty);

        verifyNever(
          () => loggerPkg.f(
            'message',
            error: 'error',
            stackTrace: StackTrace.empty,
          ),
        );
      });

      test('should be able to log when level is fatal', () {
        sut
          ..level = LogLevel.fatal
          ..fatal('message', 'error', StackTrace.empty);

        verifyLogFatalCalledOnce();
      });

      test('should be able to log when level is error', () {
        sut
          ..level = LogLevel.error
          ..fatal('message', 'error', StackTrace.empty);

        verifyLogFatalCalledOnce();
      });

      test('should be able to log when level is warning', () {
        sut
          ..level = LogLevel.warning
          ..fatal('message', 'error', StackTrace.empty);

        verifyLogFatalCalledOnce();
      });

      test('should be able to log when level is info', () {
        sut
          ..level = LogLevel.info
          ..fatal('message', 'error', StackTrace.empty);

        verifyLogFatalCalledOnce();
      });

      test('should be able to log when level is debug', () {
        sut
          ..level = LogLevel.debug
          ..fatal('message', 'error', StackTrace.empty);

        verifyLogFatalCalledOnce();
      });
    });
  });
}
