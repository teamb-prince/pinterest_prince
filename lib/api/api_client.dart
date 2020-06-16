import 'package:http/http.dart';

import 'errors/error.dart';

class ApiClient {
  static const _serverUrl = "http://localhost:8080";

  final Client _client;

  ApiClient(this._client);

  Future<Response> get(String relativeUrl) async {
    return await _makeRequestWithErrorHandler(
      _client.get("$_serverUrl$relativeUrl"),
    );
  }

  Future<Response> post(String relativeUrl, {String body}) async {
    return await _makeRequestWithErrorHandler(
      _client.post(
        "$_serverUrl$relativeUrl",
        body: body,
      ),
    );
  }

  static Future<Response> _makeRequestWithErrorHandler(
      Future<Response> requestFunction) async {
    final Response response = await requestFunction;
    if (response.statusCode >= 400) {
      throw _handleError(response.statusCode, response.body,
          response.request?.url?.toString());
    }

    return response;
  }

  static DefaultError _handleError(
      int statusCode, String errorResponse, String url) {
    if (statusCode == 400) {
      return BadRequestError();
    } else if (statusCode == 401) {
      return UnauthorizedError();
    } else if (statusCode == 403) {
      return ForbiddenServerError();
    } else if (statusCode == 404) {
      return NotFoundError(url);
    } else if (statusCode >= 500 && statusCode <= 599) {
      return UnknownServerError(errorResponse, statusCode);
    } else {
      return UnknownClientError(errorResponse);
    }
  }
}
