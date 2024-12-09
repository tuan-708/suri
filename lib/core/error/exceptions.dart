class ServerException implements Exception {
  final String message;
  const ServerException(this.message);

  @override
  String toString() {
    return message;
  }
}

class InternetException implements Exception {
  final String message;
  const InternetException(this.message);
  @override
  String toString() {
    return message;
  }
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);
  @override
  String toString() {
    return message;
  }
}

class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException(this.message);
  @override
  String toString() {
    return message;
  }
}
