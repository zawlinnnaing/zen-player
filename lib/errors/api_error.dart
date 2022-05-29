class ApiError implements Exception {
  final String statusCode;
  final String? message;
  ApiError({required this.statusCode, this.message});
  @override
  String toString() {
    return 'AppApiError: ${this.message ?? "Something went wrong"} with status code: ${this.statusCode}';
  }
}
