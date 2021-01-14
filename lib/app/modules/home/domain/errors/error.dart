abstract class HomeFailure implements Exception {
  String? get message;
}

class ConnectionError extends HomeFailure {
  final String? message;
  ConnectionError({this.message});
}

class ErrorGetChar extends HomeFailure {
  final String? message;
  ErrorGetChar({this.message});
}

class ErrorSearch extends HomeFailure {
  final String? message;
  ErrorSearch({this.message});
}