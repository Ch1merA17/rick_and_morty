sealed class AppException implements Exception {
  const AppException();

  static AppException from(Object error) =>
      error is AppException ? error : UnexpectedException(error);
}

final class NoInternetException extends AppException {
  const NoInternetException();
}

final class RequestTimeoutException extends AppException {
  const RequestTimeoutException();
}

final class NotFoundException extends AppException {
  const NotFoundException();
}

final class ServerException extends AppException {
  const ServerException({this.statusCode});

  final int? statusCode;
}

final class UnexpectedException extends AppException {
  const UnexpectedException(this.cause);

  final Object cause;
}
