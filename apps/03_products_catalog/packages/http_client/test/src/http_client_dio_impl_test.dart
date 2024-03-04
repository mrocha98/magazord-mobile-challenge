import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:magazord_http_client/src/dio/options_with_equality.dart';

import '../__mocks__/__mocks__.dart';

void main() {
  group('HttpClientDioImpl', () {
    late HttpClientDioImpl sut;
    late MockDio dio;

    setUp(() {
      dio = MockDio();
      sut = HttpClientDioImpl(dio);
    });

    group('.get', () {
      test(
        'should transform Response to HttpClientResponse then return it',
        () async {
          when(
            () => dio.get<String>(
              '/ping',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenAnswer(
            (_) async => Response(
              requestOptions: RequestOptions(),
              data: 'pong',
              statusCode: 200,
            ),
          );

          final response = await sut.get<String>(
            '/ping',
            headers: {'Accept-Language': 'en'},
            queryParameters: {'hello': 'world'},
          );

          expect(
            response,
            isA<HttpClientResponse<String>>()
                .having((r) => r.data, 'data', 'pong')
                .having((r) => r.statusCode, 'statusCode', 200),
          );
        },
      );

      test(
        'should transform DioResponse to HttpClientException then throw it',
        () async {
          final dioException = DioException(
            requestOptions: RequestOptions(),
            message: 'message',
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: 503,
              data: 'data',
            ),
          );
          when(
            () => dio.get<String>(
              '/ping',
              options: OptionsWithEquality(headers: {'Accept-Language': 'en'}),
              queryParameters: {'hello': 'world'},
            ),
          ).thenThrow(dioException);

          expect(
            () async => sut.get<String>(
              '/ping',
              headers: {'Accept-Language': 'en'},
              queryParameters: {'hello': 'world'},
            ),
            throwsA(
              isA<HttpClientException>()
                  .having((e) => e.message, 'message', 'message')
                  .having((e) => e.statusCode, 'statusCode', 503)
                  .having((e) => e.error, 'error', dioException)
                  .having(
                    (e) => e.response,
                    'response',
                    isA<HttpClientResponse<dynamic>>()
                        .having((r) => r.data, 'data', 'data')
                        .having((r) => r.statusCode, 'statusCode', 503),
                  ),
            ),
          );
        },
      );
    });
  });
}
