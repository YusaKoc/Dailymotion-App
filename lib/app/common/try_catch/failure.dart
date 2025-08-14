abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = "Network error"]) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String message = "Authentication failed"])
      : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = "Server error"]) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = "Unknown error"]) : super(message);
}
