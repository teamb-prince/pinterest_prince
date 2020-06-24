import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:pintersest_clone/api/api_client.dart';
import 'package:pintersest_clone/api/errors/error.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  MockHttpClient mockHttpClient;
  ApiClient apiClient;

  group('ApiClient error handling', () {
    setUp(() async {
      mockHttpClient = MockHttpClient();
      apiClient = ApiClient(mockHttpClient);
    });

    test(
        'when API return response with status code 401, [get] function should throw [UnauthorizedError]',
        () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) => Future.value(Response('body', 401)));

      final getFuture = apiClient.get('401');
      expect(getFuture, throwsA(isInstanceOf<UnauthorizedError>()));
    });

    test(
        'when API return response with status code 403, [get] function should throw [ForbiddenServerError]',
        () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) => Future.value(Response('body', 403)));

      final getFuture = apiClient.get('403');
      expect(getFuture, throwsA(isInstanceOf<ForbiddenServerError>()));
    });

    test(
        'when API return response with status code 404, [get] function should throw [NotFoundError]',
        () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) => Future.value(Response('body', 404)));

      final getFuture = apiClient.get('404');
      expect(getFuture, throwsA(isInstanceOf<NotFoundError>()));
    });

    test(
        'when API return response with status code 500, [get] function should throw [UnknownServerError]',
        () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) => Future.value(Response('body', 500)));

      final getFuture = apiClient.get('500');
      expect(getFuture, throwsA(isInstanceOf<UnknownServerError>()));
    });

    test(
        'when API return response with status code 422, [get] function should throw UnknownClientError',
        () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) => Future.value(Response('body', 422)));

      final getFuture = apiClient.get('422');
      expect(getFuture, throwsA(isInstanceOf<UnknownClientError>()));
    });
  });
}
