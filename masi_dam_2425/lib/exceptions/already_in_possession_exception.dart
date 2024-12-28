class AlreadyInPossessionException implements Exception {
  final String message;

  AlreadyInPossessionException(this.message);

  @override
  String toString() => message;
}