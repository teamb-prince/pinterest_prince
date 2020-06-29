mixin DefaultError implements Exception {
  String getMessage();
}

class NetworkError implements DefaultError {
  @override
  String getMessage() => 'No internet connection';
}

class BadRequestError implements DefaultError {
  @override
  String getMessage() => '(400) Bad request';
}

class ForbiddenServerError implements DefaultError {
  @override
  String getMessage() => "(403) You don't have access to this content.";
}

class NotFoundError implements DefaultError {
  final String url;

  NotFoundError(this.url);

  @override
  String getMessage() => '(404) not found\n$url';
}

class UnauthorizedError implements DefaultError {
  @override
  String getMessage() => '(401) Unauthorized connection';
}

class ConflictError implements DefaultError {
  @override
  String getMessage() => '(409) Conflict';
}

class UnknownClientError implements DefaultError {
  UnknownClientError(this._error);

  @override
  String getMessage() {
    return 'Unknown client error\n$_error';
  }

  final dynamic _error;
}

class UnknownServerError implements DefaultError {
  UnknownServerError(this._error, this.statusCode);

  @override
  String getMessage() {
    return 'Unknown server error ($statusCode)\n$_error';
  }

  final dynamic _error;
  final int statusCode;
}
