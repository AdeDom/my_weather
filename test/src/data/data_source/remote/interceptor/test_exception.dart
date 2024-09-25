class TestException implements Exception {
  TestException(this.message);

  String? message;

  @override
  String toString() {
    return message ?? '';
  }
}
